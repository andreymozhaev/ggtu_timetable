import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggtu_timetable/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Расписание',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}