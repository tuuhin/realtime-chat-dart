import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/core/local_store_context.dart';

class SetUsernameDialog extends ConsumerStatefulWidget {
  const SetUsernameDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<SetUsernameDialog> createState() => _SetUsernameDialogState();
}

class _SetUsernameDialogState extends ConsumerState<SetUsernameDialog> {
  late TextEditingController _username;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _username.text = await ref.read(localDataProvider).getUsername() ?? '';
    });
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  void _onCancel() => Navigator.of(context).pop();

  void _onChange() async {
    if (!_key.currentState!.validate()) return;
    await ref.read(localDataProvider).setUsername(_username.text);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: AlertDialog(
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        title: const Text('Change Username'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) => value != null && value.length < 5
                  ? 'A name should contain 5 characters'
                  : null,
              controller: _username,
              decoration: InputDecoration(
                filled: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary),
                ),
                helperText: "Enter the username",
                hintText: "Flutter",
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: _onCancel, child: const Text('Cancel')),
          ElevatedButton(onPressed: _onChange, child: const Text('Change'))
        ],
      ),
    );
  }
}
