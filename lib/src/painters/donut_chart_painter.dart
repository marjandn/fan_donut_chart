import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../donut_chart.dart';

class DonutChartPainter extends CustomPainter {
  final List<DonutSectionModel> data;
  final double strokeWidth;

  DonutChartPainter({required this.data, this.strokeWidth = 40});

  @override
  void paint(Canvas canvas, Size size) {
    final double total = data.fold(0, (sum, item) => sum + item.value);

    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;
    final adjustedRadius = radius - strokeWidth / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -90.0;
    for (var item in data) {
      final sweepAngle = (item.value / total) * 360;
      paint.color = item.color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: adjustedRadius),
        startAngle * (math.pi / 180),
        sweepAngle * (math.pi / 180),
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
