import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/menu/visualizer.dart';

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
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Visualizer(set1: {DateTime.now().toString()}, set2: {DateTime.now().toString()})
              )
          );
        },
        child: const Text("create graph", style: TextStyle(color: Colors.red),),
    );
  }
}