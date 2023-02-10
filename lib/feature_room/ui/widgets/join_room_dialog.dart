import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../context/room_context.dart';
import 'room_model_viewer.dart';

class JoinRoomDialog extends ConsumerWidget {
  final bool isChecking;
  final void Function(bool) onChecking;
  final void Function()? onJoin;
  final String roomId;
  const JoinRoomDialog({
    Key? key,
    required this.roomId,
    required this.isChecking,
    required this.onChecking,
    this.onJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text.rich(
        TextSpan(text: "Code :", children: [
          TextSpan(
              text: roomId, style: const TextStyle(color: Colors.deepPurple))
        ]),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2),
      ),
      content: ref.watch(checkRoomStateProvider(roomId)).when(
          success: (data, message) => RoomModelViewer(roomModel: data!),
          failed: (message, err, data) => Text(message),
          loading: (__, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Checking", textAlign: TextAlign.center),
                  SizedBox(width: 10),
                  CircularProgressIndicator()
                ],
              )),
      actions: [
        Builder(builder: (context) {
          final roomProvider = ref
              .watch(checkRoomStateProvider(roomId).notifier)
              .joinRoomNotifier;
          return TextButton(
            onPressed: roomProvider.allowed ? onJoin : null,
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
