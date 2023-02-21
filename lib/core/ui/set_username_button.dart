import 'package:flutter/material.dart';

import 'set_username_dialog.dart';

class SetUsernameButton extends StatelessWidget {
  const SetUsernameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
          context: context, builder: (context) => const SetUsernameDialog()),
      icon: const Icon(Icons.person_2_outlined),
    );
  }
}
