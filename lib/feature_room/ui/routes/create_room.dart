import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/core/local_data_repo.dart';

import '../../../core/local_store_context.dart';
import '../widgets/create_room_dialog.dart';

class CreateRoomRoute extends ConsumerStatefulWidget {
  const CreateRoomRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRoomRoute> createState() => _CreateRoomRouteState();
}

class _CreateRoomRouteState extends ConsumerState<CreateRoomRoute> {
  late TextEditingController _maxAttendesCount;
  late TextEditingController _usernameField;
  late LocalDataRepo _repo;

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
    _repo = ref.read(localDataProvider);

    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallBack);
  }

  @override
  void dispose() {
    _maxAttendesCount.dispose();
    _usernameField.dispose();
    super.dispose();
  }

  void _createRoom() async {
    if (!_fromKey.currentState!.validate()) return;
    if (await _repo.getUsername() != _usernameField.text) {
      _repo.setUsername(_usernameField.text);
    }
    if (!mounted) return;
    await showDialog(
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
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  helperText: "Username used for the chat",
                  hintText: "Flutter",
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) => value != null && value.isEmpty
                    ? "Enter attendes count"
                    : value != null && int.tryParse(value) == null
                        ? "Non integer values cannot be an attendes count"
                        : null,
                controller: _maxAttendesCount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).colorScheme.primary),
                  ),
                  helperText: "Attendes Count",
                  hintText: "4",
                  prefixIcon: const Icon(Icons.numbers),
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
