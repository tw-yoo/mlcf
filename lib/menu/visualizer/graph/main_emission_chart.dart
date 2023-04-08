
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/inference_emission.dart';
import '../../../model/train_emission.dart';
import '../../../providers/emission_manager.dart';
import '../../../providers/selected_options.dart';
import 'chart_data.dart';

class MainEmissionChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MainEmissionChart({Key? key}) : super(key: key);
  @override
  _MainEmissionChartState createState() => _MainEmissionChartState();
}

class _MainEmissionChartState extends State<MainEmissionChart> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [];
    context.watch<SelectedOptions>().selectedModelList
        .forEach((element) {

          List<InferenceEmission> inferenceEmissionList = context.watch<EmissionManager>()
              .inferenceEmissionList;

          List<TrainEmission> trainEmissionList = context.watch<EmissionManager>()
              .tranEmissionList;

      InferenceEmission inferenceEmission = inferenceEmissionList
          .firstWhere((infEmission) => infEmission.architecture == element);

      TrainEmission trainEmission = trainEmissionList
          .firstWhere((trEmission) => trEmission.architecture == element);

      double totalEmission = trainEmission.co2PerHour +
          inferenceEmission.co2PerInference;

      data.add(ChartData(element, totalEmission));
    });

    double maxY = 1.0;
    if (data.isNotEmpty) {
      maxY = data.map((e) => e.y).reduce(max) * 1.1;
    }

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: maxY, interval: maxY * 0.1),
        tooltipBehavior: _tooltip,
        selectionGesture: ActivationMode.doubleTap,
        onSelectionChanged: (e) => {
          context.read<EmissionManager>()
              .updateSelectedArchitecture(
              e.pointIndex
          )
        },
        series: <ChartSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: 'Co2eq (Kg) for training an hour',
              color: Color.fromRGBO(8, 142, 255, 1))
        ]);
  }
}
