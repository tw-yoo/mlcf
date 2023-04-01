import 'dart:math';

import 'package:mlcf/menu/selector/selector.dart';

List data0X = [1, 1, 2, 2, 3, 3, 4, 4,];
List data0Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List data1X = [1, 1, 2, 3, 1, 3, 5, 4,];
List data1Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List data2X = [1, 3, 1, 5, 8, 1, 2, 7,];
List data2Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List data3X = [3, 6, 0, 7, 1, 2, 4, 5,];
List data3Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List data4X = [4, 2, 7, 9, 0, 1, 3, 5,];
List data4Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List data5X = [6, 1, 2, 2, 4, 9, 2, 4,];
List data5Y = [0, 1, 2, 3, 4, 5, 6, 7,];

List<List> getData(int rand) {
  if (rand == 0) {
    return [data0X, data0Y];
  } else if (rand == 1) {
    return [data1X, data1Y];
  } else if (rand == 2) {
    return [data2X, data2Y];
  } else if (rand == 3) {
    return [data3X, data3Y];
  } else if (rand == 4) {
    return [data4X, data4Y];
  } else {
    return [data5X, data5Y];
  }
}

// random 데이터 생성하는 함수. x축은 10개, y는 100범위까지
List<List> getDataPair() {
  List dataX = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,];
  List dataY = [];
  for(var i = 0; i<dataX.length; i++) {
    dataY.add(
        (i * 10) + Random().nextInt(10)
    );
  }
  return [dataX, dataY];
}