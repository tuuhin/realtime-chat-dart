import 'package:flutter/material.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  void _createRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Room"),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                onPressed: _createRoom,
                child: Text("Create Room")),
            const Divider(),
            TextButton(
                style: TextButton.styleFrom(fixedSize: Size(size.width, 50)),
                onPressed: () {},
                child: Text("Join a room"))
          ],
        ),
      ),
    );
  }
}
