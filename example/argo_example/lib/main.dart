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
        wrapConfig: WrapperConfig(
          globalBreakpoints: ScreenBreakpoints.values(
            mobile: const SBValue.max(550),
            tablet: const SBValue.max(1200),
            desktop: const SBValue.inf(),
          ),
        ),
        child: MainScreen(),
      ),
    );
  }
}
