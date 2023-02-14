import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/db/chat_operation_repo.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:server/responses/api_expection.dart';
import 'package:shared/shared.dart';

import '../../main.dart';

/// This hold the list of [WebSocketChannel]
/// Though this is just a in-memory mapping [Map] hoding th [String] room with
/// the [List] of [WebSocketChannel]s
/// The similar thing can be applied with pubsub feature of the redis server
/// in a long running and traffic based application
final Map<String, List<WebSocketChannel>> _channelsRoom = {};

Future<Response> onRequest(RequestContext context, String room) async {
  logger.shout(_channelsRoom);
  //room validation
  final roomRepo = context.read<RoomOperations>();
  final roomValidation = await roomRepo.checkRoom(room: room);

  if (roomValidation?.state != null &&
      roomValidation!.state != RoomState.joinable) {
    return ApiException.failedDependency(
      details: 'Cannot join the room,either room do not exits or room is full',
    );
  }
  final query = context.request.uri.queryParameters;
  if (!query.containsKey('username')) {
    return ApiException.failedDependency(details: 'Username not found');
  }
  final username = query['username'];

  if (username == null) {
    return ApiException.failedDependency(
      details: 'Username not provided',
    );
  }
  final chatRepo = context.read<ChatOperationRepo>();

  final handler = webSocketHandler(
    (channel, protocol) async {
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
      //welcome message to the stream
      channel.sink.add(WsBaseMessages.joined(username));

      channel.stream.listen(
        (event) {
          // Get all the associated sockets [WebSocketChannel] present
          // with the same room then channelize through all the sockets
          // not brodcasting it (sending to all sockets except the channel )
          final sockets = _channelsRoom[room];
          print(event);
          final message = WsBaseMessages.parseMessage(event as String);
          chatRepo.insertChat(chat: message.model!);

          sockets?.forEach(
            (socket) => socket != channel
                ? socket.sink.add(WsBaseMessages.message(message.model!))
                : null,
          );
        },
        onDone: () async {
          _channelsRoom.update(room, (value) => value..remove(channel));

          _channelsRoom[room]?.forEach((others) {
            others.sink.add(
              WsBaseMessages.dissconnected(username,
                  reason: channel.closeReason),
            );
          });
          await roomRepo.updateRoom(
            room: room,
            newCount: _channelsRoom[room]?.length ?? 0,
          );
        },
        onError: (_) async {
          print('some error occured !!');
          _channelsRoom.update(room, (value) => value..remove(channel));
          _channelsRoom[room]?.forEach((others) => others.sink.add(
              WsBaseMessages.dissconnected(username,
                  reason: channel.closeReason)));
          await roomRepo.updateRoom(
            room: room,
            newCount: _channelsRoom[room]?.length ?? 0,
          );
        },
      );
    },
  );
  return handler(context);
}
