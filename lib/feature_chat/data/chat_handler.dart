import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reatime_chat/main.dart';
import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/local_data_repo.dart';

class ChatHandler {
  final RoomModel room;
  final LocalDataRepo _localData;

  static final _endpoint =
      dotenv.get('WEBSOCKET_HOST', fallback: 'ws://10.0.2.2:8080/ws');

  ChatHandler(this._localData, {required this.room});

  late final WebSocketChannel _channel;

  Future<WebSocketChannel> init() async {
    String username = await _localData.getUsername() ?? 'anonymous';
    final uri = Uri.parse('$_endpoint/${room.roomId}?username=$username');
    _channel = WebSocketChannel.connect(uri);
    return _channel;
  }

  Future<void> close() async => _channel.sink.close();
}
