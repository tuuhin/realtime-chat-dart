import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../context/room_context.dart';
import '../widgets/create_room_dialog.dart';

class CreateRoomRoute extends ConsumerStatefulWidget {
  const CreateRoomRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRoomRoute> createState() => _CreateRoomRouteState();
}

class _CreateRoomRouteState extends ConsumerState<CreateRoomRoute> {
  late TextEditingController _maxAttendesCount;
  late TextEditingController _usernameField;

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  Future<void> _postFrameCallBack(Duration _) async {
    final prev = await ref.read(localDataProvider).getUsername();
    if (prev == null) return;
    _usernameField.text = prev;
  }

  @override
  void initState() {
    super.initState();
    _maxAttendesCount = TextEditingController();
    _usernameField = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallBack);
  }

  @override
  void dispose() {
    _maxAttendesCount.dispose();
    _usernameField.dispose();
    super.dispose();
  }

  void _createRoom() {
    if (!_fromKey.currentState!.validate()) return;
    ref.read(localDataProvider).setUsername(_usernameField.text);
    showDialog(
      context: context,
      builder: (context) =>
          CreateRoomDialog(maxCount: int.parse(_maxAttendesCount.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Room"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              Text(
                "Create a roomID",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              Text(
                "Created a room Id that can be used by other to join to this room",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) => value != null && value.length < 5
                    ? "Username should contain 5 chrs"
                    : null,
                controller: _usernameField,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                  ),
                  helperText: "Username used for the chat",
                  hintText: "Flutter",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) => value != null &&
                        value.isNotEmpty &&
                        int.tryParse(value) == null
                    ? "Enter some integer "
                    : null,
                controller: _maxAttendesCount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                  ),
                  helperText: "Attendes Count",
                  hintText: "4",
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: _createRoom,
          child: const Text("Create room"),
        ),
      ),
    );
  }
}
