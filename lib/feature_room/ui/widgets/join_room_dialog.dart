import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../context/room_context.dart';
import 'room_model_viewer.dart';

class JoinRoomDialog extends ConsumerStatefulWidget {
  final String roomId;
  const JoinRoomDialog({
    super.key,
    required this.roomId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends ConsumerState<JoinRoomDialog> {
  RoomModel? roomModel;

  void _onJoin() => context.push("/chats", extra: roomModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text.rich(
        TextSpan(
          text: "Code :",
          children: [
            TextSpan(
              text: widget.roomId,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2),
      ),
      content: ref.watch(checkRoomStateProvider(widget.roomId)).when(
            success: (data, message) {
              if (roomModel == null && data?.state == RoomState.joinable) {
                roomModel = data?.room;
              }
              return RoomModelViewer(roomModel: data!);
            },
            failed: (message, err, data) => Text(message),
            loading: (__, _) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Checking", textAlign: TextAlign.center),
                SizedBox(width: 10),
                CircularProgressIndicator()
              ],
            ),
          ),
      actions: [
        Builder(builder: (context) {
          final roomProvider = ref
              .watch(checkRoomStateProvider(widget.roomId).notifier)
              .joinRoomNotifier;
          return TextButton(
            onPressed: roomProvider.allowed ? _onJoin : null,
            child: Text(
              'Join Chat ',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
            ),
          );
        })
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
