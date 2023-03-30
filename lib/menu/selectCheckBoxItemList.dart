import 'package:flutter/material.dart';
import 'package:mlcf/menu/selector.dart';

// SelectCheckBoxItem을 담고있는 리스트
class SelectCheckBoxItemList extends StatelessWidget {

  final SelectBoxType selectBoxType;

  const SelectCheckBoxItemList({super.key, required this.selectBoxType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(selectBoxType.name.toString()),
        const SelectCheckBoxItem(name: "option1"),
        const SelectCheckBoxItem(name: "option2")
      ],
    );
  }
}

// CheckBox
class SelectCheckBoxItem extends StatefulWidget {

  final String name;

  const SelectCheckBoxItem({ Key? key, required this.name }): super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectCheckBoxItemState();
}

class _SelectCheckBoxItemState extends State<SelectCheckBoxItem> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.purpleAccent;
      }
      return Colors.red;
    }

    return CheckboxListTile(
      title: Text(widget.name),
      checkColor: Colors.white,
      // fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}