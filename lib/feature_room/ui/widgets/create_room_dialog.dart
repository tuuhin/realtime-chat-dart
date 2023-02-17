import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:reatime_chat/feature_room/context/room_context.dart';

import 'create_room_viewer.dart';

class CreateRoomDialog extends ConsumerStatefulWidget {
  final int maxCount;
  const CreateRoomDialog({
    super.key,
    required this.maxCount,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRoomDialogState();
}

class _CreateRoomDialogState extends ConsumerState<CreateRoomDialog> {
  void _setClipBoardData({required String data}) async =>
      await Clipboard.setData(ClipboardData(text: data));

  void _onJoin() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      title: const Text("Creating chat room "),
      content: ref.watch(createRoomStateProvider(widget.maxCount)).when(
          success: (data, message) => CreateRoomViewer(
                data: data,
                onCopy: () => _setClipBoardData(data: data.roomId),
              ),
          failed: (message, err, data) => Text(message),
          loading: (_, __) => const Text("loading")),
      actions: [
        Builder(builder: (context) {
          final roomProvider = ref
              .watch(createRoomStateProvider(widget.maxCount).notifier)
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
    );
  }
}
