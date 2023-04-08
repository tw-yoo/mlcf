import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlcf/model/inference_emission.dart';
import 'package:mlcf/model/train_emission.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';
import 'menu/selector/selector.dart';
import 'menu/visualizer/visualizer.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

void readCsv(BuildContext context)  {

  rootBundle.load('inference.csv').then((ByteData data) {
    String csvString = utf8.decode(data.buffer.asUint8List());
    List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);
    List<String> headers = List<String>.from(csvList[0]);

    List<Map<String, dynamic>> jsonData = [];
    for (var i = 1; i < csvList.length; i ++) {
      Map<String, dynamic> row = {};
      for (var j = 0; j < headers.length; j++) {
        row[headers[j]] = csvList[i][j];
      }
      jsonData.add(row);
    }

    for (var i = 0; i < jsonData.length; i ++) {

      InferenceEmission emission = InferenceEmission(
          jsonData[i]["architecture"]!!,
          jsonData[i]["gpu_instance"]!!,
          jsonData[i]["kwh"]!!,
          jsonData[i]["co2eq_per_inference"]!!
      );
      context.read<EmissionManager>()
          .addOptionByBoxType(EmissionType.inference, emission);

      inferenceEmissionList.add(emission);
    }
  });

  rootBundle.load('train.csv').then((ByteData data) {
    String csvString = utf8.decode(data.buffer.asUint8List());
    List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);
    List<String> headers = List<String>.from(csvList[0]);

    List<Map<String, dynamic>> jsonData = [];
    for (var i = 1; i < csvList.length; i ++) {
      Map<String, dynamic> row = {};
      for (var j = 0; j < headers.length; j++) {
        row[headers[j]] = csvList[i][j];
      }
      jsonData.add(row);
    }

    for (var i = 0; i < jsonData.length; i ++) {

      TrainEmission emission = TrainEmission(
          jsonData[i]["architecture"]!!,
          jsonData[i]["gpu_instance"]!!,
          jsonData[i]["kwh"]!!,
          jsonData[i]["co2eq_per_hour"]!!
      );
      context.read<EmissionManager>()
          .addOptionByBoxType(EmissionType.train, emission);

      trainEmissionList.add(emission);
    }
  });
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedOptions()),
        ChangeNotifierProvider(create: (_) => EmissionManager()),
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

    readCsv(context);

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



