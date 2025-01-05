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
      title: 'Flutter Demo',
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
          data: [
            DonutSectionModel(label: "Flutter", value: 40, color: Colors.blue),
            DonutSectionModel(label: "React", value: 30, color: Colors.red),
            DonutSectionModel(
                label: "Vue", value: 20, color: const Color.fromARGB(255, 173, 171, 41)),
            DonutSectionModel(
                label: "Laravel", value: 80, color: const Color.fromARGB(255, 173, 51, 136)),
            DonutSectionModel(
                label: "IONIC", value: 10, color: const Color.fromARGB(255, 59, 102, 202)),
          ],
        ),
      ),
    );
  }
}
