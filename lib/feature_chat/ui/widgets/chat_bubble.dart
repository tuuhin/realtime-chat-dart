import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ChatBubble extends CustomPainter {
  final Color fillColor;
  final double curve;
  final ChatOwner owner;
  const ChatBubble({
    this.fillColor = Colors.purple,
    this.curve = 10,
    this.owner = ChatOwner.other,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final triangle = Path();

    if (owner == ChatOwner.self) {
      triangle
        ..moveTo(size.width, 20)
        ..lineTo(size.width + 10, 0)
        ..lineTo(size.width - 10, 0);
    } else {
      triangle
        ..moveTo(0, 20)
        ..lineTo(10, 0)
        ..lineTo(-10, 0);
    }

    canvas.drawPath(
        Path()
          ..moveTo(size.width, 0)
          ..addRRect(BorderRadius.circular(curve)
              .toRRect(Rect.fromLTRB(size.width - curve, 0, 0, size.height))),
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill);
    canvas.drawPath(triangle, Paint()..color = fillColor);
    // canvas.drawPaint(Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
