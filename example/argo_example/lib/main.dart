import 'package:argo/argo.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: context.widthPct(10),
          height: context.heightPct(20),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
