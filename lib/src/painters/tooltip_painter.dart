import 'package:flutter/material.dart';

class LShapePainter extends CustomPainter {
  final double lineLength;
  late final Offset boxPosition;
  final String lable;

  LShapePainter({this.lable = '', this.lineLength = 60}) {
    boxPosition = Offset(100, -lineLength);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawLine(Offset(10, -lineLength), const Offset(10, 0), paint);

    canvas.drawLine(Offset(10, -lineLength), boxPosition, paint);

    TextSpan span = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 20),
      text: lable,
    );
    TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    double textWidth = textPainter.size.width;
    double padding = 20;
    double boxWidth = textWidth + padding;

    Rect rect = Rect.fromLTWH(
      boxPosition.dx,
      boxPosition.dy - 20,
      boxWidth,
      50,
    );
    RRect roundedRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(80));

    canvas.drawRRect(
        roundedRect, paint..color = const Color.fromARGB(139, 190, 190, 190));

    double textOffsetX = boxPosition.dx + (boxWidth - textWidth) / 2;
    double textOffsetY = boxPosition.dy - 8;

    textPainter.paint(canvas, Offset(textOffsetX, textOffsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
