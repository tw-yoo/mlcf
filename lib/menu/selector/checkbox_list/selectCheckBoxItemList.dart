import 'package:flutter/material.dart';
import 'package:mlcf/menu/selector/selector.dart';
import 'package:mlcf/model/inference_emission.dart';
import 'package:mlcf/model/train_emission.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';


// SelectCheckBoxItem을 담고있는 리스트
class SelectCheckBoxItemList extends StatefulWidget {
  final SelectBoxType selectBoxType;
  const SelectCheckBoxItemList({super.key, required this.selectBoxType});

  @override
  State<StatefulWidget> createState() => _SelectCheckboxItemListState();
}

class _SelectCheckboxItemListState extends State<SelectCheckBoxItemList> {

  String filter = "";
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController
        .addListener(() {
          filter = _searchTextController.text;
          setState(() {});
        });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    List<TrainEmission> list = context.read<EmissionManager>().trainEmissionList;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 40),
            child: const Text(
                "Architectures",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -25),
            child: Container(
              height: 60.0,
              padding: EdgeInsets.only(left: 20, top: 8),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _searchTextController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search..',
                ),
              ),
            ),
          ),
                        ...list.map((e) => e.architecture)
                        .toSet().toList()
                            .map((String m) {
                              return filter == null || filter == ''
                                  ? SelectCheckBoxItem(
                                name: m,
                                selectBoxType: widget.selectBoxType,
                              )
                                  : m.toLowerCase().contains(filter.toLowerCase())
                                  ? SelectCheckBoxItem(
                                name: m,
                                selectBoxType: widget.selectBoxType,
                              )
                                  : Container();
                            }).toList(),
        ],
      ),
    );
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