import 'package:argo/argo.dart';
import 'package:argo_example/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Argo Example App',
      debugShowCheckedModeBanner: false,
      home: ResponsiveWrapper(
        globalBreakpoints: ScreenBreakpoints(
          mobile: 321,
          tablet: 650,
          desktop: 1100,
        ),
        child: MainScreen(),
      ),
    );
  }
}
