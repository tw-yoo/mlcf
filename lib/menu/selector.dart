import 'package:flutter/material.dart';
import 'package:mlcf/menu/button.dart';
import 'package:mlcf/menu/selectCheckBoxItemList.dart';

enum SelectBoxType { data, model }

class Selector extends StatefulWidget {

  const Selector({super.key, selectedDataSet, selectedModelSet});

  @override
  State<StatefulWidget> createState() => SelectorState();
}

class SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        children: const [
          SelectCheckBoxItemList(selectBoxType: SelectBoxType.data),
          SelectCheckBoxItemList(selectBoxType: SelectBoxType.model),
          VisualizeButton(),
        ],
      ),
    );
  }
}