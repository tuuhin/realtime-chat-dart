import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../room_context.dart';

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
      title: Text("Checking room: $roomId"),
      content: StreamBuilder(
        stream: ref.read(roomprovider).checkRoom(roomId),
        builder: (context, snapshot) =>
            (snapshot.hasData && snapshot.data != null)
                ? snapshot.data!.when(
                    success: (data, message) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(data!.state.toString()),
                            if (data.room != null) ...[
                              Text(data.room!.roomId),
                              Text(data.room!.id)
                            ]
                          ],
                        ),
                    failed: (message, err, data) => Text(message),
                    loading: (__, _) =>
                        const Text("loading", textAlign: TextAlign.center))
                : const SizedBox.shrink(),
      ),
      actions: [
        TextButton(
            onPressed: isChecking ? onJoin : null, child: const Text('Join'))
      ],
    );
  }
}
