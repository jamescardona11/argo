import 'package:argo_example/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Argo Example App',
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}
