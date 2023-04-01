import 'package:flutter/material.dart';
import 'package:mlcf/menu/selector/button/visualize_button.dart';
import 'package:mlcf/menu/selector/checkbox_list/selectCheckBoxItemList.dart';

import 'button/reset_button.dart';

enum SelectBoxType { data, model }

class OptionSelector extends StatefulWidget {

  const OptionSelector({super.key, selectedDataSet, selectedModelSet});

  @override
  State<StatefulWidget> createState() => OptionSelectorState();
}

class OptionSelectorState extends State<OptionSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: Column(
        children: const [
          SelectCheckBoxItemList(selectBoxType: SelectBoxType.data),
          // ResetButton(selectBoxType: SelectBoxType.data,),
          SelectCheckBoxItemList(selectBoxType: SelectBoxType.model),
          // ResetButton(selectBoxType: SelectBoxType.model,),
          VisualizeButton(),
        ],
      ),
    );
  }
}