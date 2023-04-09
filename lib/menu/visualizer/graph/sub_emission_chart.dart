
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/inference_emission.dart';
import '../../../model/train_emission.dart';
import '../../../providers/emission_manager.dart';
import '../../../providers/selected_options.dart';
import '../model/chart_data.dart';

class SubEmissionChart extends StatefulWidget {
  const SubEmissionChart({super.key});

  @override
  State<StatefulWidget> createState() => _SubEmissionChartState();
}

class _SubEmissionChartState extends State<SubEmissionChart> {

  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  PieData? trainEmissionData;
  PieData? inferenceEmissionData;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TrainEmission? trainEmission = null;
    InferenceEmission? inferenceEmission = null;

    String? selectedArchitecture = context.watch<EmissionManager>().selectedArchitecture;

    if (context.watch<EmissionManager>().trainEmissionList.map((e) => e.architecture).contains(selectedArchitecture)) {

      trainEmission = context.watch<EmissionManager>()
          .trainEmissionList
          .firstWhere((e) => e.architecture == selectedArchitecture);

      inferenceEmission = context.watch<EmissionManager>()
          .inferenceEmissionList
          .firstWhere((e) => e.architecture == selectedArchitecture);

      trainEmissionData = PieData(
          "train",
          trainEmission.co2PerHour,
        "train",
      );
      inferenceEmissionData = PieData(
          "inference",
          inferenceEmission.co2PerInference * 1000,
        "inference",
      );
    }

    if (!context.watch<EmissionManager>().showSubChart) {
      return const Text("");
    } else {

      return Center(
          child: SfCircularChart(
              title: ChartTitle(text: "Details of ${selectedArchitecture!}"),
              legend: Legend(isVisible: true),
              series: <PieSeries<PieData, String>>[
                PieSeries<PieData, String>(
                    explode: false,
                    explodeIndex: 0,
                    dataSource: [
                      trainEmissionData!,
                      inferenceEmissionData!
                    ],
                    xValueMapper: (PieData data, _) => data.xData,
                    yValueMapper: (PieData data, _) => data.yData,
                    dataLabelMapper: (PieData data, _) => data.text,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ]
          )
      );
    }
  }
}