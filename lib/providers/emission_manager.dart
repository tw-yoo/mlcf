import 'package:flutter/cupertino.dart';
import 'package:mlcf/model/inference_emission.dart';
import 'package:mlcf/model/train_emission.dart';

List<TrainEmission> trainEmissionList = [];
List<InferenceEmission> inferenceEmissionList = [];

enum EmissionType { train, inference }


class EmissionManager with ChangeNotifier {

  final List<TrainEmission> _trainEmissionList = [];
  final List<InferenceEmission> _inferenceEmissionList = [];

  String? _selectedArchitecture;

  List<TrainEmission> get trainEmissionList => _trainEmissionList;
  List<InferenceEmission> get inferenceEmissionList => _inferenceEmissionList;
  String? get selectedArchitecture => _selectedArchitecture;

  bool showMainChart = false;
  bool showSubChart = false;



  void addOptionByBoxType(EmissionType emissionType, dynamic option) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.add(option);
    // notifyListeners();
  }

  void removeOptionByType(EmissionType emissionType, dynamic option) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.remove(option);
  }

  void emptyOptionByType(EmissionType emissionType) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.clear();
  }

  void updateSelectedArchitecture(String selectedArchitecture) {
    _selectedArchitecture = selectedArchitecture;
    notifyListeners();
  }

  void updateShowMainChart(bool show) {
    showMainChart = show;
    notifyListeners();
  }

  void updateShowSubChart(bool show) {
    showSubChart = show;
    notifyListeners();
  }

  List<dynamic>? getListByEmissionBoxType(EmissionType emissionType) {
    if (emissionType == EmissionType.train) {
      return _trainEmissionList;
    } else if (emissionType == EmissionType.inference) {
      return _inferenceEmissionList;
    } else {
      return null;
    }
  }

  void notify() {
    notifyListeners();
  }
}