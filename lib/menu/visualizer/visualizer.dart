import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/model/inference_emission.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/train_emission.dart';
import '../../providers/selected_options.dart';
import 'graph/main_emission_chart.dart';
import 'graph/sub_emission_chart.dart';

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
          // margin: EdgeInsets.fromLTRB(
              // screenWidth * 0.1,
              // screenHeight * 0.2
              // screenWidth * 0.1,
              // screenHeight * 0.2
          // ),
          child: MainEmissionChart()
        ),
        Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.4,
          // margin: EdgeInsets.fromLTRB(
              // screenWidth * 0.1,
              // screenHeight * 0.2,
              // screenWidth * 0.1,
              // screenHeight * 0.2
          // ),
          child: const SubEmissionChart(),
        )
      ],
    );
  }
}


