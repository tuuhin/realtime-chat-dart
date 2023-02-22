import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/main.dart';

import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../chat_context.dart';
import 'user_chats.dart';

class UserChatsWindow extends ConsumerWidget {
  final WebSocketChannel channel;
  final ScrollController scroll;
  final RoomModel room;
  const UserChatsWindow({
    super.key,
    required this.room,
    required this.channel,
    required this.scroll,
  });

  void _schedularCallBack(Duration _) {
    logger.fine("scrolling to bottom");
    scroll.animateTo(scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scrollbar(
      controller: scroll,
      child: CustomScrollView(
        controller: scroll,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text.rich(
              TextSpan(
                text: 'Chat room :',
                children: [
                  TextSpan(
                    text: room.roomId,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: ref.read(chatRepoProvider(channel)).recieveChat(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                SchedulerBinding.instance
                    .addPostFrameCallback(_schedularCallBack);

                return UserChats(chats: snapshot.data!);
              }
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
