import 'package:app/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/MainScreen.dart';
import 'package:app/screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmpe',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
