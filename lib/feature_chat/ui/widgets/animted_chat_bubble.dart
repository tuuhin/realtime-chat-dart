import 'package:flutter/material.dart';
import 'package:reatime_chat/feature_chat/ui/widgets/chat_bubble.dart';
import 'package:shared/shared.dart';

class AnimatedChatBubble extends StatefulWidget {
  final ChatMessageInfoModel chatInfo;
  const AnimatedChatBubble({Key? key, required this.chatInfo})
      : super(key: key);

  @override
  State<AnimatedChatBubble> createState() => _AnimtedChatBubbleState();
}

class _AnimtedChatBubbleState extends State<AnimatedChatBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _offset = Tween<Offset>(
            begin: widget.chatInfo.owner == ChatOwner.self
                ? const Offset(1, 0)
                : const Offset(-1, 0),
            end: Offset.zero)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _scale = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Align(
        alignment: widget.chatInfo.owner != ChatOwner.self
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .5),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(4),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: _offset.value,
              child: Transform.scale(scale: _scale.value, child: child),
            ),
            child: CustomPaint(
              painter: ChatBubble(
                owner: widget.chatInfo.owner,
                fillColor: widget.chatInfo.owner == ChatOwner.self
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.chatInfo.owner == ChatOwner.other)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.chatInfo.model?.username ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.chatInfo.model?.text ?? '',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: widget.chatInfo.owner == ChatOwner.self
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                            ),
                      ),
                    ),
                    if (widget.chatInfo.model != null)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.chatInfo.model!.time.simpleFormat,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
