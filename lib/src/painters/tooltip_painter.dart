import 'package:flutter/material.dart';

class LShapePainter extends CustomPainter {
  final double lineLength;
  late final Offset boxPosition;
  final String lable;

  final Color bgColor;
  final TextStyle textStyle;
  final double borderRadius;

  LShapePainter({
    this.lable = '',
    this.lineLength = 60,
    required this.bgColor,
    required this.textStyle,
    required this.borderRadius,
  }) : boxPosition = Offset(100, -lineLength);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawLine(Offset(10, -lineLength), const Offset(10, 0), paint);

    canvas.drawLine(Offset(10, -lineLength), boxPosition, paint);

    TextSpan span = TextSpan(
      style: textStyle,
      text: lable,
    );
    TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    double textWidth = textPainter.size.width;
    double textHeight = textPainter.size.height;
    double padding = 20;
    double boxWidth = textWidth + padding;
    double boxHeight = textHeight + padding;

    Rect rect = Rect.fromLTWH(
      boxPosition.dx,
      boxPosition.dy - 20,
      boxWidth,
      boxHeight,
    );
    RRect roundedRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    canvas.drawRRect(roundedRect, paint);

    double textOffsetX = boxPosition.dx + (boxWidth - textWidth) / 2;
    double textOffsetY = boxPosition.dy - 10;

    textPainter.paint(canvas, Offset(textOffsetX, textOffsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
