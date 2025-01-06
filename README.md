Rounded Donut Chart with a custom tooltip.

![rounded_donut_chart](https://github.com/user-attachments/assets/bfd351db-658d-495d-ae06-88c936193ae5)


## Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  fan_donut_chart: latest
```

Import the segmented progress bar package like this:

```dart
import 'package:donut_chart/donut_chart.dart';
```

## Usage

Simply create a DonutChartWidget widget, and pass the required params:

```dart
DonutChartWidget(
          size: 200,
          strokeWidth: 30,
          tooltipBgColor: const Color.fromARGB(154, 178, 178, 178),
          data: [
            DonutSectionModel(label: "Instagram", value: 40, color: const Color(0xFFcd2e64)),
            DonutSectionModel(label: "Facebook", value: 30, color: const Color(0xFF4453b3)),
            DonutSectionModel(label: "X", value: 20, color: const Color(0xFF5aa9f2)),
            DonutSectionModel(label: "Threads", value: 10, color: const Color(0xFFe35655)),
          ],
        ),
          
```

## Customization

Customize the DonutChartWidget widget with these parameters:

```dart

  /// A list of [DonutSectionModel] objects that contain the data for the donut chart.
  /// Each [DonutSectionModel] should have a [label] and a [value] to define the chart's segments.
  final List<DonutSectionModel> data;

  /// The size of the donut chart. Default value is 200.
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
  final TextStyle tooltipTextStyle;

  /// The length of the line connecting the tooltip to the hovered segment. Default value is 40.
  /// This controls the length of the line that connects the tooltip with the respective chart segment.
  final double tooltipLineLength;
```
