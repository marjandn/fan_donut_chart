import 'package:donut_chart/donut_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donut Chart Package',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DonutChartApp(),
    );
  }
}

class DonutChartApp extends StatelessWidget {
  const DonutChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Donut Chart Example'),
        ),
        body: DonutChartWidget(
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
      ),
    );
  }
}
