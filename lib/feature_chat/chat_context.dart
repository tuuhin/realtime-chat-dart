import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/feature_chat/data/chat_handler.dart';
import 'package:reatime_chat/main.dart';
import 'package:shared/shared.dart';

final chatHandler =
    Provider.family<ChatHandler, ChatHandlerModel>((ref, model) {
  ref.onDispose(() => logger.severe("Chat handler is disposed"));
  return ChatHandler(info: model)..init();
});
