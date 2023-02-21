import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../context/context.dart';
import './widgets.dart';

class CreateRoomDialog extends ConsumerStatefulWidget {
  final int maxCount;
  const CreateRoomDialog({super.key, required this.maxCount});

  @override
  ConsumerState<CreateRoomDialog> createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends ConsumerState<CreateRoomDialog> {
  RoomModel? _roomModel;
  void _setClipBoardData({required String data}) async {
    await Clipboard.setData(ClipboardData(text: data));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_roomModel?.roomId} copied to clipboard')));
  }

  void _onJoin() => context.push("/chats", extra: _roomModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      title: const Text("Creating chat room "),
      content: ref.watch(createRoomStateProvider(widget.maxCount)).when(
            success: (data, _) {
              _roomModel = data;
              return CreateRoomViewer(
                data: data,
                onCopy: () => _setClipBoardData(data: data.roomId),
              );
            },
            failed: (message, _, __) => Text(message),
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
              .watch(createRoomStateProvider(widget.maxCount).notifier)
              .joinRoomNotifier;
          return TextButton(
            onPressed: roomProvider.allowed ? _onJoin : null,
            child: Text(
              'Join Chat ',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          );
        })
      ],
    );
  }
}
