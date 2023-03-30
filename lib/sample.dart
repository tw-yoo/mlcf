import 'package:flutter/material.dart';
import 'package:mlcf/menu/visualizer.dart';
import 'package:provider/provider.dart';

class CheckboxModel extends ChangeNotifier {
  List<bool> _isCheckedList = [false, false, false];

  List<bool> get isCheckedList => _isCheckedList;

  void setCheckedList(List<bool> checkedList) {
    _isCheckedList = checkedList;
    notifyListeners();
  }
}

class CheckboxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckboxModel>(
      create: (_) => CheckboxModel(),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text('Checkbox 1'),
            value: Provider.of<CheckboxModel>(context).isCheckedList[0],
            onChanged: (value) {
              final model = Provider.of<CheckboxModel>(context, listen: false);
              final newList = List<bool>.from(model.isCheckedList);
              newList[0] = value!;
              model.setCheckedList(newList);
            },
          ),
          CheckboxListTile(
            title: Text('Checkbox 2'),
            value: Provider.of<CheckboxModel>(context).isCheckedList[1],
            onChanged: (value) {
              final model = Provider.of<CheckboxModel>(context, listen: false);
              final newList = List<bool>.from(model.isCheckedList);
              newList[1] = value!;
              model.setCheckedList(newList);
            },
          ),
          CheckboxListTile(
            title: Text('Checkbox 3'),
            value: Provider.of<CheckboxModel>(context).isCheckedList[2],
            onChanged: (value) {
              final model = Provider.of<CheckboxModel>(context, listen: false);
              final newList = List<bool>.from(model.isCheckedList);
              newList[2] = value!;
              model.setCheckedList(newList);
            },
          ),
          ElevatedButton(
            onPressed: () {
              final model = Provider.of<CheckboxModel>(context, listen: false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Visualizer(set1: {"!"}, set2: {"@"}),
                ),
              );
            },
            child: Text('Draw Graph'),
          ),
        ],
      ),
    );
  }
}