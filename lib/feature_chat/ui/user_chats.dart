import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'widgets/animted_chat_bubble.dart';

class UserChats extends StatelessWidget {
  final List<ChatMessageInfoModel> chats;
  const UserChats({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final data = chats[index];
          if (data.type == ChatMessageDataType.joined) {
            return Align(
              alignment: Alignment.center,
              child: Chip(
                label: Text(data.extra ?? 'joined the chat'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            );
          }
          if (data.type == ChatMessageDataType.disconnected) {
            return Align(
              alignment: Alignment.center,
              child: Chip(
                label: Text(data.extra ?? 'left the chat'),
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            );
          }
          return AnimatedChatBubble(chatInfo: chats[index]);
        }, childCount: chats.length),
      );
}
