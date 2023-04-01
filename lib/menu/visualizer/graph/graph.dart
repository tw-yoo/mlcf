import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/sample_data_result.dart';

// TODO: option에 따라 다른 그래프 보여주도록 수정.
// 현재는 데이터를 랜덤하게 보여주도록 되어있음.
LineChartData mainChart(int selectedDataCount, int selectedModelCount) {

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 9,
    minY: 0,
    maxY: 100,
    lineBarsData: getLineChartBarDataList(selectedDataCount * selectedModelCount)
  );
}

List<LineChartBarData> getLineChartBarDataList(int length) {
  List<LineChartBarData> list = [];
  for(var i=0;i<length;i++) {
    list.add(
      getLineChartBarData()
    );
  }
  return list;
}

LineChartBarData getLineChartBarData() {
  List<List> dataPair = getDataPair();
  List dataX = dataPair[0];
  List dataY = dataPair[1];

  List<FlSpot> spots = [];

  for(var i=0;i<dataX.length;i++) {
    spots.add(
      FlSpot(dataX[i], dataY[i])
    );
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    barWidth: 5,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: true,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
    color: Color.fromRGBO(getRandInt(256), getRandInt(256), getRandInt(256), 100)
  );
}

int getRandInt(int v) {
  return Random().nextInt(v);
}