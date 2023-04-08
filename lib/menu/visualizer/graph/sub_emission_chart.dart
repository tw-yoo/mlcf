
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/inference_emission.dart';
import '../../../model/train_emission.dart';
import '../../../providers/emission_manager.dart';
import '../../../providers/selected_options.dart';
import 'chart_data.dart';

class SubEmissionChart extends StatefulWidget {
  const SubEmissionChart({super.key});

  @override
  State<StatefulWidget> createState() => _SubEmissionChartState();
}

class _SubEmissionChartState extends State<SubEmissionChart> {

  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  ChartData? trainEmissionData;
  ChartData? inferenceEmissionData;

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

    if (context.watch<EmissionManager>().tranEmissionList.map((e) => e.architecture).contains(selectedArchitecture)) {

      trainEmission = context.watch<EmissionManager>()
          .tranEmissionList
          .firstWhere((e) => e.architecture == selectedArchitecture);

      inferenceEmission = context.watch<EmissionManager>()
          .inferenceEmissionList
          .firstWhere((e) => e.architecture == selectedArchitecture);

      trainEmissionData = ChartData(
          "train",
          trainEmission.co2PerHour
      );
      inferenceEmissionData = ChartData(
          "inference",
          inferenceEmission.co2PerInference * 1000
      );
    }

    if (!context.watch<EmissionManager>().showSubChart) {
      return const Text("");
    } else {

      double maxY = max(trainEmissionData!.y, inferenceEmissionData!.y);

      return SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: maxY * 1.1, interval: maxY * 0.1),
          tooltipBehavior: _tooltip,
          selectionGesture: ActivationMode.doubleTap,
          onSelectionChanged: (e) {},
          series: <ChartSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
                dataSource: [
                  trainEmissionData!!,
                  inferenceEmissionData!!
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Co2eq (Kg) for training an hour',
                color: Color.fromRGBO(8, 142, 255, 1))
          ]);
    }
  }
}