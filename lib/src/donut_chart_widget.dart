import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../donut_chart.dart';
import 'painters/donut_chart_painter.dart';
import 'painters/tooltip_painter.dart';

/// A customizable donut chart widget for displaying segmented data with an optional tooltip on hover.
class DonutChartWidget extends StatefulWidget {
  /// A list of [DonutSectionModel] objects that contain the data for the donut chart.
  /// Each [DonutSectionModel] should have a [label] and a [value] to define the chart's segments.
  final List<DonutSectionModel> data;

  /// The size of the donut chart (diameter). Default value is 200.
  /// This will define the overall size of the donut chart.
  final double size;

  /// The thickness of the donut chart's stroke. Default value is 40.
  /// This defines how thick the border of each segment will be.
  final double strokeWidth;

  /// The background color of the tooltip that appears when hovering over a segment.
  /// Default value is a semi-transparent gray: [Color.fromARGB(146, 199, 199, 199)].
  final Color tooltipBgColor;

  /// The radius of the tooltip's rounded corners. Default value is 10.
  /// This determines how rounded the corners of the tooltip will be.
  final double tooltipRadius;

  /// The text style for the label inside the tooltip. Default value is [TextStyle(color: Colors.black, fontSize: 18)].
  /// You can customize the font size, color, and other text styling here.
  final TextStyle tooltipTextStyle;

  /// The length of the line connecting the tooltip to the hovered segment. Default value is 40.
  /// This controls the length of the line that connects the tooltip with the respective chart segment.
  final double tooltipLineLength;

  const DonutChartWidget(
      {super.key,
      required this.data,
      this.size = 200,
      this.strokeWidth = 40,
      this.tooltipBgColor = const Color.fromARGB(146, 199, 199, 199),
      this.tooltipLineLength = 40,
      this.tooltipRadius = 10,
      this.tooltipTextStyle = const TextStyle(color: Colors.black, fontSize: 18)});

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  String? hoveredLabel;
  Offset? hoveredPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
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

                final renderBox = context.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(event.position);

                setState(() {
                  if (section != null) {
                    hoveredLabel = section.label;
                    hoveredPosition = localPosition;
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
            top: hoveredPosition!.dy,
            child: CustomPaint(
              painter: LShapePainter(
                lable: hoveredLabel!,
                bgColor: widget.tooltipBgColor,
                borderRadius: widget.tooltipRadius,
                textStyle: widget.tooltipTextStyle,
                lineLength: widget.tooltipLineLength,
              ),
            ),
          ),
      ],
    );
  }

  DonutSectionModel? _getHoveredSection(Offset position, Size size) {
    double total = widget.data.fold(0, (sum, item) => sum + item.value);
    double startAngle = -90.0;

    final rect = Offset.zero & size;
    final center = rect.center;

    final distanceFromCenter = (position - center).distance;

    final innerRadius = widget.size / 2 - widget.strokeWidth;
    final outerRadius = widget.size / 2;

    if (distanceFromCenter < innerRadius || distanceFromCenter > outerRadius) {
      return null;
    }

    final angle = math.atan2(position.dy - center.dy, position.dx - center.dx);
    double adjustedAngle = (angle * 180 / math.pi + 360) % 360;

    for (var item in widget.data) {
      final sweepAngle = (item.value / total) * 360;

      final normalizedStartAngle = (startAngle + 360) % 360;
      final normalizedEndAngle = (normalizedStartAngle + sweepAngle) % 360;

      if (normalizedStartAngle < normalizedEndAngle) {
        if (adjustedAngle >= normalizedStartAngle && adjustedAngle < normalizedEndAngle) {
          return item;
        }
      } else {
        if (adjustedAngle >= normalizedStartAngle || adjustedAngle < normalizedEndAngle) {
          return item;
        }
      }

      startAngle += sweepAngle;
    }

    return null;
  }
}
