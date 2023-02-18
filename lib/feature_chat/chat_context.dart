import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/local_store_context.dart';
import './data/chat_handler.dart';
import './data/chat_repo_impl.dart';
import './repository/chat_repository.dart';
import 'package:reatime_chat/main.dart';
import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'channel_state_provider.dart';

final channelHandler = StateNotifierProvider.autoDispose
    .family<ChannelNotifier, Resource<WebSocketChannel>, RoomModel>(
        (ref, room) {
  final channelNotifier =
      ChannelNotifier(ChatHandler(ref.read(localDataProvider), room: room));

  ref.onDispose(() {
    channelNotifier.close();
    logger.shout("WS HAS BEEN DISPOSED OR CLOSED");
  });

  return channelNotifier..init();
});

final chatRepoProvider = Provider.family<ChatRepository, WebSocketChannel>(
  (ref, channel) {
    ref.onDispose(() =>
        logger.severe("Channel repo has been disposed has been disposed"));
    return ChatRepoImpl(ref.read(localDataProvider), channel);
  },
);
