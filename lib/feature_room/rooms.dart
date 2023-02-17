import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Rooms extends StatelessWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.secondary,
                      offset: const Offset(10, 10),
                      blurRadius: 10,
                      spreadRadius: 2)
                ],
              ),
              child: Image.asset(
                "assets/images/speech.png",
                scale: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Create or join a room to chat",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: .9),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(fixedSize: Size(size.width, 50)),
                onPressed: () => context.push('/create-room'),
                child: const Text("Create Room")),
            const Divider(),
            TextButton(
                style: TextButton.styleFrom(fixedSize: Size(size.width, 50)),
                onPressed: () => context.push('/join-room'),
                child: const Text("Join a room"))
          ],
        ),
      ),
    );
  }
}
