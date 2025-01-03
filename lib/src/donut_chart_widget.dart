import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'model/donut_chart_model.dart';
import 'painters/donut_chart_painter.dart';
import 'painters/tooltip_painter.dart';

class DonutChartWidget extends StatefulWidget {
  final List<DonutChartData> data;
  final double size;
  final double strokeWidth;

  const DonutChartWidget({
    super.key,
    required this.data,
    this.size = 200,
    this.strokeWidth = 40,
  });

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  String? hoveredLabel;
  Offset? hoveredPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: widget.size,
            width: widget.size,
            child: MouseRegion(
              onHover: (event) {
                final section = _getHoveredSection(
                  event.localPosition,
                  Size(widget.size, widget.size),
                );

                setState(() {
                  if (section != null) {
                    hoveredLabel = section.label;
                    hoveredPosition = event.position;
                  } else {
                    hoveredLabel = null;
                    hoveredPosition = null;
                  }
                });
              },
              onExit: (_) {
                setState(() {
                  hoveredLabel = null;
                  hoveredPosition = null;
                });
              },
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: DonutChartPainter(
                  data: widget.data,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
            ),
          ),
        ),
        if (hoveredLabel != null && hoveredPosition != null)
          Positioned(
            left: hoveredPosition!.dx,
            top: hoveredPosition!.dy - 60,
            child: CustomPaint(
              // This will make it cover the entire screen
              painter: LShapePainter(lable: hoveredLabel!), // Use the custom painter here
            ),
          ),
      ],
    );
  }

  DonutChartData? _getHoveredSection(Offset position, Size size) {
    double total = widget.data.fold(0, (sum, item) => sum + item.value);
    double startAngle = -90.0; // Initial angle starts at -90°

    final rect = Offset.zero & size;
    final center = rect.center;

    // Calculate the angle between the mouse and the center of the chart
    final angle = math.atan2(position.dy - center.dy, position.dx - center.dx);
    double adjustedAngle = (angle * 180 / math.pi + 360) % 360;

    // Loop through each section and check if the mouse is in its range
    for (var item in widget.data) {
      final sweepAngle = (item.value / total) * 360;

      // Normalize startAngle to the range [0, 360)
      final normalizedStartAngle = (startAngle + 360) % 360;
      final normalizedEndAngle = (normalizedStartAngle + sweepAngle) % 360;

      // Check if adjustedAngle falls within the section's range
      if (normalizedStartAngle < normalizedEndAngle) {
        // Normal case: angle range does not wrap around 360°
        if (adjustedAngle >= normalizedStartAngle && adjustedAngle < normalizedEndAngle) {
          return item;
        }
      } else {
        // Wrapping case: angle range crosses 360° boundary
        if (adjustedAngle >= normalizedStartAngle || adjustedAngle < normalizedEndAngle) {
          return item;
        }
      }

      startAngle += sweepAngle;
    }

    return null;
  }
}
