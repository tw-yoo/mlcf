import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {

  final Set set1;
  final Set set2;

  const Visualizer({super.key, required this.set1, required this.set2});

  @override
  State<StatefulWidget> createState() => VisualizerState();
}

class VisualizerState extends State<Visualizer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.set1.toString()),
        Text(widget.set2.toString())
      ],
    );
  }

}