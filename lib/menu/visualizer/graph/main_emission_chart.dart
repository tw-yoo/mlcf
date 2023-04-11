
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/inference_emission.dart';
import '../../../model/train_emission.dart';
import '../../../providers/emission_manager.dart';
import '../../../providers/selected_options.dart';
import '../model/chart_data.dart';

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
              .trainEmissionList;

      InferenceEmission inferenceEmission = inferenceEmissionList
          .firstWhere((infEmission) => infEmission.architecture == element);

      TrainEmission trainEmission = trainEmissionList
          .firstWhere((trEmission) => trEmission.architecture == element);

      double totalEmission = trainEmission.co2PerHour +
          inferenceEmission.co2PerInference;

      data.add(ChartData(element, totalEmission));
    });

    List<ChartData> arrangedData = context.read<SelectedOptions>()
        .arrangeChartDataListByOptions(data);


    double maxY = 1.0;
    if (arrangedData.isNotEmpty) {
      maxY = arrangedData.map((e) => e.y).reduce(max) * 1.1;
    }

    if (!context.watch<EmissionManager>().showMainChart) {
      return const Text("");
    } else {
      return SfCartesianChart(
          title: ChartTitle(
              text: 'Carbon emission of selected architecture(s)',
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          primaryXAxis: CategoryAxis(
            title: AxisTitle(
                text: "Architecture",
              textStyle: TextStyle(fontWeight: FontWeight.bold)
            )
          ),
          primaryYAxis: NumericAxis(
              title: AxisTitle(
                  text: "CO2 Kilograms",
                  textStyle: TextStyle(fontWeight: FontWeight.bold)
              ),
              minimum: 0,
              maximum: maxY,
              interval: maxY * 0.1
          ),
          tooltipBehavior: _tooltip,
          selectionGesture: ActivationMode.doubleTap,
          onSelectionChanged: (e) {

            String selectedArchitecture = context.read<SelectedOptions>().selectedModelList[e.pointIndex];

            context.read<EmissionManager>()
                .updateSelectedArchitecture(
                selectedArchitecture
            );
            context.read<EmissionManager>()
                .updateShowSubChart(true);
          },
          series: <ChartSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
                dataSource: arrangedData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Kg co2eq for training one hour and inferring 1,000 times',
                color: Color.fromRGBO(8, 142, 255, 1),
                animationDuration: 500
            ),
          ]);
    }
  }
}
