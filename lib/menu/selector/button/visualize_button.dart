import 'dart:math';

import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/menu/visualizer/visualizer.dart';

class VisualizeButton extends StatefulWidget {
  const VisualizeButton({super.key});

  @override
  State<StatefulWidget> createState() => VisualizeButtonState();
}

class VisualizeButtonState extends State<VisualizeButton> {
  @override
  Widget build(BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: ElevatedButton(
            onPressed: () {
              context.read<SelectedOptions>().notify();
              context.read<EmissionManager>().updateShowMainChart(true);
              context.read<EmissionManager>().updateShowSubChart(false);
            },
            child: Text("create graph", style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          ),
        );

  }
}