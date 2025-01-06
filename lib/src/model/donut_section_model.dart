import 'package:flutter/material.dart';

/// Represents a section of a donut chart.
class DonutSectionModel {
  /// The label for this section of the chart.
  /// This is displayed as part of the tooltip.
  final String label;

  /// The value for this section of the chart.
  /// Determines the size of the section relative to other sections.
  final double value;

  /// The color for this section of the chart.
  /// Used to visually distinguish this section in the donut chart.
  final Color color;

  DonutSectionModel({
    required this.label,
    required this.value,
    required this.color,
  });
}
