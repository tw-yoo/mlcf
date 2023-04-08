import 'package:flutter/material.dart';
import 'package:mlcf/menu/selector/selector.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';


// SelectCheckBoxItem을 담고있는 리스트
class SelectCheckBoxItemList extends StatelessWidget {

  final SelectBoxType selectBoxType;

  const SelectCheckBoxItemList({super.key, required this.selectBoxType});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Flex(
      // width: screenHeight * 0.3,
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,

      children: [
        Flexible(
            child:
            Column(
              children: [
                Text(selectBoxType.name),
                Container(
                    height: screenHeight * 0.3,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: SingleChildScrollView(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, int idx) {
                              return SelectCheckBoxItem(
                                name: context.watch<EmissionManager>().inferenceEmissionList[idx].architecture,
                                selectBoxType: selectBoxType,
                              );
                            },
                            separatorBuilder: (BuildContext ctx, int idx) {
                              return const Divider();
                            },
                            itemCount: context.watch<EmissionManager>().inferenceEmissionList.length
                        )
                    )
                )
              ],
            )
        ),
      ]
    ) ;

  }
}

// CheckBox
class SelectCheckBoxItem extends StatefulWidget {

  final String name;
  final SelectBoxType selectBoxType;

  const SelectCheckBoxItem({ Key? key, required this.name, required this.selectBoxType }): super(key: key);

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

        if (value == true) {
          context.read<SelectedOptions>().addOptionByBoxType(widget.selectBoxType, widget.name);
        } else {
          context.read<SelectedOptions>().removeOptionByType(widget.selectBoxType, widget.name);
        }

        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}