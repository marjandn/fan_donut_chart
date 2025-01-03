import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../model/donut_chart_model.dart';

class DonutChartPainter extends CustomPainter {
  final List<DonutChartData> data;
  final double strokeWidth;

  DonutChartPainter({required this.data, this.strokeWidth = 40});

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.fold(0, (sum, item) => sum + item.value);
    double startAngle = -90.0;

    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (var item in data) {
      final sweepAngle = (item.value / total) * 360;

      paint.color = item.color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        _degreesToRadians(startAngle),
        _degreesToRadians(sweepAngle),
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
