import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'intro.dart';
import 'gangetabell.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GangetabellApp());
}

class GangetabellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: IntroScreen(),
    );
  }
}
