import 'dart:math';

import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/menu/visualizer/visualizer.dart';

import '../selector.dart';

class ResetButton extends StatefulWidget {

  final SelectBoxType selectBoxType;

  const ResetButton({super.key, required this.selectBoxType});


  @override
  State<StatefulWidget> createState() => ResetButtonState();
}

class ResetButtonState extends State<ResetButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<SelectedOptions>().emptyOptionByType(widget.selectBoxType);
      },
      child: const Text("reset option", style: TextStyle(color: Colors.white),),
    );
  }
}