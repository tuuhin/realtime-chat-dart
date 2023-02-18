import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/feature_chat/chat_context.dart';

import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'ui/widgets/chats_widgets.dart';

class Chats extends ConsumerStatefulWidget {
  final RoomModel room;
  const Chats({super.key, required this.room});

  @override
  ConsumerState<Chats> createState() => _ChatsState();
}

class _ChatsState extends ConsumerState<Chats> {
  late ScrollController _controller;

  void _onSend(String value, WebSocketChannel channel) {
    if (_controller.offset < _controller.position.maxScrollExtent * .8) {
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
    }
    ref.read(chatRepoProvider(channel)).sendMessage(value, widget.room);
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(channelHandler(widget.room)).when(
            success: (channel, _) => UserChatsWindow(
              channel: channel,
              room: widget.room,
              scroll: _controller,
            ),
            failed: (message, _, __) => const Center(
              child: Text('connection failed'),
            ),
            loading: (_, __) => const Center(
              child: Text('Loading your connection'),
            ),
          ),
      bottomNavigationBar: ref.watch(channelHandler(widget.room)).maybeWhen(
            orElse: () => null,
            success: (channel, _) =>
                ChatBottomBar(onSend: (str) => _onSend(str, channel)),
          ),
    );
  }
}
