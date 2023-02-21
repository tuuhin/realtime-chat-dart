import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/ui/ui.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Chat App'),
        centerTitle: true,
        actions: const [SetUsernameButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    offset: const Offset(10, 10),
                    blurRadius: 20,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Image.asset(
                "assets/images/speech.png",
                scale: 2,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Create or join a room to chat ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(size.width, 50)),
              onPressed: () => context.push('/create-room'),
              child: const Text("Create Room"),
            ),
            const Divider(),
            TextButton(
              style: TextButton.styleFrom(fixedSize: Size(size.width, 50)),
              onPressed: () => context.push('/join-room'),
              child: const Text("Join a room"),
            )
          ],
        ),
      ),
    );
  }
}
