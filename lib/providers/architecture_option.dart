import 'package:flutter/cupertino.dart';

class ArchitectureOption with ChangeNotifier {
  final List optionList = [];

  void addArchitectureOption(String option ) {
    optionList.add(option);
  }

  void notify() {
    notifyListeners();
  }
}