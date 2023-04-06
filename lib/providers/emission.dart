import 'package:flutter/cupertino.dart';
import 'package:mlcf/model/inference_emission.dart';
import 'package:mlcf/model/train_emission.dart';

List<TrainEmission> trainEmissionList = [];
List<InferenceEmission> inferenceEmissionList = [];

enum EmissionType { train, inference }

class EmissionManager with ChangeNotifier {

  final List<TrainEmission> _trainEmissionList = [];
  final List<InferenceEmission> _inferenceEmissionList = [];

  List<TrainEmission> get tranEmissionList => _trainEmissionList;
  List<InferenceEmission> get inferenceEmissionList => _inferenceEmissionList;

  void addOptionByBoxType(EmissionType emissionType, dynamic option) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.add(option);
    notifyListeners();
  }

  void removeOptionByType(EmissionType emissionType, dynamic option) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.remove(option);
  }

  void emptyOptionByType(EmissionType emissionType) {
    List? selectedList = getListByEmissionBoxType(emissionType);
    selectedList?.clear();
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