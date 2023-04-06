import 'package:flutter/cupertino.dart';

import '../menu/selector/selector.dart';

class SelectedOptions with ChangeNotifier {

  final List _selectedDataList = [];
  final List<String> _selectedModelList = [];
  
  List get selectedDataList => _selectedDataList;
  List<String> get selectedModelList => _selectedModelList;

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

  List getSelectedDataList() {
    return _selectedDataList;
  }

  void notify() {
    notifyListeners();
  }
}