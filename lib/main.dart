import 'package:flutter/material.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';
import 'menu/selector/selector.dart';
import 'menu/visualizer/visualizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedOptions()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI ArchiEV',
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {

  final int value = 0;

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  Set selectedDataSet = {};
  Set selectedModelSet = {};
  DateTime clickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("AI ArchiEV")
      ),
      body: Row(
        children: [
          Flexible(flex: 2, fit: FlexFit.tight, child: OptionSelector(selectedDataSet: selectedDataSet, selectedModelSet: selectedModelSet,)),
          const Flexible(flex: 7, fit: FlexFit.tight, child: Visualizer()),
        ],
      ),
    );
  }
}