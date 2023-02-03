import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/responses/api_expection.dart';

import '../main.dart';

/// This hold the list of [WebSocketChannel]
/// Though this is just a in-memory mapping [Map] hoding th [String] room with
/// the [List] of [WebSocketChannel]s
/// The similar thing can be applied with pubsib feature of the redis server
/// in a long running and traffic based application
final Map<String, List<WebSocketChannel>> _channelsRoom = {};

Future<Response> onRequest(RequestContext context) async {
  logger.shout(_channelsRoom);
  // final repo = context.read<ChatOperationRepo>();
  final query = context.request.uri.queryParameters;
  if (!query.containsKey('room')) {
    return ApiException.failedDependency(details: 'Room Id was not found');
  }
  final roomId = query['room'];

  if (roomId == null) {
    return ApiException.failedDependency(
        details: 'Room parameter was not given');
  }

  final handler = webSocketHandler(
    (channel, protocol) {
      if (_channelsRoom.containsKey(roomId)) {
        _channelsRoom.update(roomId, (value) => [...value, channel]);
      } else {
        _channelsRoom.putIfAbsent(roomId, () => [channel]);
      }
      channel.stream.listen(
        (event) {
          /// Get all the associated sockets [WebSocketChannel] present
          /// with the same room
          final sockets = _channelsRoom[roomId];
          sockets?.forEach(
            (socket) => (socket != channel) ? socket.sink.add(event) : null,
          );
        },
        onDone: () => _channelsRoom.update(
          roomId,
          (value) => value..remove(channel),
        ),
      );
    },
  );
  return handler(context);
}
