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
        return ElevatedButton(
        onPressed: () {
            context.read<SelectedOptions>().notify();
            context.read<EmissionManager>().updateShowSubChart(false);
        },
        child: const Text("create graph", style: TextStyle(color: Colors.white),),
    );
  }
}