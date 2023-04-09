import 'package:flutter/cupertino.dart';

import '../menu/selector/selector.dart';
import '../menu/visualizer/model/chart_data.dart';

enum SortOption { name, emission }
enum OrderOption { asc, desc }

String getSortOptionNameToDisplay(SortOption option) {
  if (option == SortOption.name) {
    return "Name";
  } else if (option == SortOption.emission) {
    return "Carbon Emission";
  } else {
    return "";
  }
}

String getOrderOptionNameToDisplay(OrderOption option) {
  if (option == OrderOption.asc) {
    return "Ascending";
  } else if (option == OrderOption.desc) {
    return "Descending";
  } else {
    return "";
  }
}

class SelectedOptions with ChangeNotifier {

  final List _selectedDataList = [];
  final List<String> _selectedModelList = [];
  
  List get selectedDataList => _selectedDataList;
  List<String> get selectedModelList => _selectedModelList;

  SortOption selectedSortOption = SortOption.name;
  OrderOption selectedOrderOption = OrderOption.asc;

  void addOptionByBoxType(SelectBoxType selectBoxType, String option) {
    List? selectedList = getListBySelectBoxType(selectBoxType);
    selectedList?.add(option);
  }

  void removeOptionByType(SelectBoxType selectBoxType, String option) {
    List? selectedList = getListBySelectBoxType(selectBoxType);
    selectedList?.remove(option);
  }

  void emptyOptionByType(SelectBoxType selectBoxType) {
    List? selectedList = getListBySelectBoxType(selectBoxType);
    selectedList?.clear();
  }

  List? getListBySelectBoxType(SelectBoxType selectBoxType) {
    if (selectBoxType == SelectBoxType.data) {
      return _selectedDataList;
    } else if (selectBoxType == SelectBoxType.architecture) {
      return _selectedModelList;
    } else {
      return null;
    }
  }

  void updateSortOption(String option) {
    if (option == "Name") {
      selectedSortOption = SortOption.name;
    } else if (option == "Carbon Emission") {
      selectedSortOption = SortOption.emission;
    }
  }

  void updateOrderOption(String option) {
    if (option == "Ascending") {
      selectedOrderOption = OrderOption.asc;
    } else if (option == "Descending") {
      selectedOrderOption = OrderOption.desc;
    }
  }

  List<ChartData> arrangeChartDataListByOptions(List<ChartData> originList) {

    List<ChartData> listSortedBySortOption = [];
    if (selectedSortOption == SortOption.name) {
      originList.sort((a, b) =>
        a.x.toLowerCase().compareTo(b.x.toLowerCase())
      );
      listSortedBySortOption = originList;
    } else if (selectedSortOption == SortOption.emission) {
      originList.sort((a, b) =>
        a.y.compareTo(b.y)
      );
      listSortedBySortOption = originList;
    } else {
      listSortedBySortOption = [];
    }

    if (selectedOrderOption == OrderOption.asc) {
      return listSortedBySortOption;
    } else if (selectedOrderOption == OrderOption.desc) {
      return listSortedBySortOption.reversed.toList();
    } else {
      return listSortedBySortOption;
    }
  }

  void notify() {
    notifyListeners();
  }
}