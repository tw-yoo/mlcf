import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_options.dart';
import 'graph/graph.dart';

class Visualizer extends StatefulWidget {

  const Visualizer({super.key});

  @override
  State<StatefulWidget> createState() => VisualizerState();
}

class VisualizerState extends State<Visualizer> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int randomNumber = Random().nextInt(5);

    return Column(
      children: [
        Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.4,
          margin: EdgeInsets.fromLTRB(
              screenWidth * 0.1,
              screenHeight * 0.2,
              screenWidth * 0.1,
              screenHeight * 0.2
          ),
          child: const BarChartCus()
          // LineChart(
            // mainChart(
            //     context.watch<SelectedOptions>().selectedModelList
            // ),

              // BarChartSample3() as LineChartData
          // ),
        )
      ],
    );
  }
}


