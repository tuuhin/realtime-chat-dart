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
            Image.asset("assets/images/speech.png", scale: 2),
            Text(
              "Chat With Me",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(fixedSize: Size(size.width, 50)),
                onPressed: () {},
                child: Text("Create Room")),
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
