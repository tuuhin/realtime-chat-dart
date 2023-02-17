import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../context/room_context.dart';
import '../widgets/widgets.dart';

class JoinRoomRoute extends ConsumerStatefulWidget {
  const JoinRoomRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinRoomRouteState();
}

class _JoinRoomRouteState extends ConsumerState<JoinRoomRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _roomId;

  void _checkRoom() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      barrierDismissible: ref
          .watch(checkRoomStateProvider(_roomId!).notifier)
          .joinRoomNotifier
          .allowed,
      context: context,
      builder: (context) => JoinRoomDialog(roomId: _roomId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
        title: const Text("Join Room"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Enter the room ID to join the chat",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
            ),
            const SizedBox(height: 10),
            Text(
              "A room Id compormised of 4 characters if you don't have an ID then create one to start the chat",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 15),
            RoomIdFiller(
              formKey: _formKey,
              charCount: 4,
              capitalization: TextCapitalization.characters,
              onSubmit: (fi) => _roomId = fi,
              onChange: (str) =>
                  _roomId = _roomId == null ? str : _roomId! + str,
              decoration: InputDecoration(
                filled: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),

            // const Spacer(),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(fixedSize: Size(size.width, 50)),
            //   onPressed: _checkRoom,
            //   child: const Text("Check cerdentials"),
            // )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
            onPressed: _checkRoom, child: const Text('Check Credentials')),
      ),
    );
  }
}
