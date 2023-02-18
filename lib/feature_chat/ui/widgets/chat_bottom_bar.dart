import 'package:flutter/material.dart';
import 'package:reatime_chat/main.dart';

class ChatBottomBar extends StatefulWidget {
  final void Function(String) onSend;

  const ChatBottomBar({Key? key, required this.onSend}) : super(key: key);

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  late TextEditingController _controller;

  void _onSend() async {
    if (_controller.text.isEmpty) return;
    logger.fine("message sent");
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomAppBar(
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: _onSend,
                child: const Icon(Icons.send),
              )
            ],
          ),
        ),
      );
}
