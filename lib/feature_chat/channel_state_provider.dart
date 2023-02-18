import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'data/chat_handler.dart';

class ChannelNotifier extends StateNotifier<Resource<WebSocketChannel>> {
  final ChatHandler _chatHandler;
  ChannelNotifier(this._chatHandler) : super(Resource.loading());

  void init() async {
    try {
      state = Resource.success(
          data: await _chatHandler.init(),
          message: "SOCKET CONNECTED SUCCESSFULLY");
    } on WebSocketChannelException catch (ws) {
      state =
          Resource.failed(message: ws.message ?? "SOCKET CONNECTION FAILED ");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      state = Resource.failed(message: "UNKNOWN ERROR");
    }
  }

  void close() => _chatHandler.close();
}
