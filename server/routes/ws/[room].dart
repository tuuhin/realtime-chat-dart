import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/respository/repository.dart';

import 'package:shared/shared.dart';
import '../../main.dart';

/// This hold the list of [WebSocketChannel]
/// Though this is just a `in-memory mapping` [Map] hoding th [String] room with
/// the [List] of [WebSocketChannel]s
/// The similar thing can be applied with pubsub feature of the redis server
/// for a long running and traffic based application
final Map<String, List<WebSocketChannel>> _channelsRoom = {};

Future<Response> onRequest(RequestContext context, String room) async {
  logger.shout(_channelsRoom);
  //room validation
  final roomRepo = context.read<RoomOperations>();
  final roomValidation = await roomRepo.checkRoom(room: room);

  final query = context.request.uri.queryParameters;
  final chatRepo = context.read<ChatOperationRepo>();

  final handler = webSocketHandler(
    (channel, protocol) async {
      // Room State validation
      if (roomValidation.state != RoomState.joinable) {
        await channel.sink.close(
          WsCloseCodes.mandatoryExtensionNotFound.closeCode,
          'Room is not joinable',
        );
        return;
      }
      // QueryParms validation
      if (!query.containsKey('username')) {
        await channel.sink.close(
          WsCloseCodes.mandatoryExtensionNotFound.closeCode,
          'username not found',
        );
        return;
      }
      final username = query['username']!;

      // Updating the `_channelsRoom` as per the join sequence
      if (_channelsRoom.containsKey(room)) {
        _channelsRoom.update(room, (value) => value..add(channel));
      } else {
        _channelsRoom.putIfAbsent(room, () => [channel]);
      }
      if (_channelsRoom[room]?.length != null) {
        await roomRepo.updateRoom(
          room: room,
          newCount: _channelsRoom[room]!.length,
        );
      }
      //send all the previous chats stored in mongodb database
      await channel.sink.addStream(
        chatRepo.streamChats(room: room).asyncMap(
              (chat) => WsBaseMessages.message(
                chat,
                owner: chat.username == username
                    ? ChatOwner.self
                    : ChatOwner.other,
              ),
            ),
      );

      //welcome message to the stream
      _channelsRoom[room]?.forEach(
        (others) => others.sink.add(WsBaseMessages.joined(username)),
      );

      channel.stream.listen(
        (event) async {
          // Get all the associated sockets [WebSocketChannel] present
          // with the same room then channelize through all the sockets
          // not brodcasting it (sending to all sockets except the channel )
          final sockets = _channelsRoom[room];

          try {
            final message = WsBaseMessages.parseMessage(event as String);
            final savedModel = await chatRepo.insertChat(chat: message.model!);

            // print(savedModel);

            sockets?.forEach(
              (socket) => socket.sink.add(
                WsBaseMessages.message(
                  savedModel,
                  owner: channel == socket ? ChatOwner.self : ChatOwner.other,
                ),
              ),
            );
          } on FormatException {
            logger.info('format exception');
            await channel.sink.close(
              WsCloseCodes.closeUnsupportedPayLoad.closeCode,
              WsCloseCodes.closeUnsupportedPayLoad.name,
            );
          } catch (e) {
            logger.shout(e);
            await channel.sink.close(
              WsCloseCodes.closeProtocolError.closeCode,
              WsCloseCodes.closeProtocolError.name,
            );
          }
        },
        onDone: () async {
          logger.fine('closed the stream');
          _channelsRoom.update(room, (value) => value..remove(channel));

          _channelsRoom[room]?.forEach(
            (others) => others.sink.add(
              WsBaseMessages.dissconnected(
                username,
                reason: channel.closeReason,
              ),
            ),
          );
          await roomRepo.updateRoom(
            room: room,
            newCount: _channelsRoom[room]?.length ?? 0,
          );
        },
        onError: (_) async {
          logger.shout('some error occured !!');
          _channelsRoom.update(room, (value) => value..remove(channel));
          _channelsRoom[room]?.forEach(
            (others) => others.sink.add(
              WsBaseMessages.dissconnected(
                username,
                reason: channel.closeReason,
              ),
            ),
          );
          await roomRepo.updateRoom(
            room: room,
            newCount: _channelsRoom[room]?.length ?? 0,
          );
        },
        cancelOnError: true,
      );
    },
  );
  return handler(context);
}
