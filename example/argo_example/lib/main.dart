import 'package:argo/argo.dart';
import 'package:argo/responsive/orientation_layout_builder.dart';
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
          child: Column(
            children: [
              Center(
                child: Text('Hello World'),
              ),
              OrientationLayoutBuilder(
                portrait: (context) {
                  return Container(
                    width: context.widthPct(100),
                    height: context.heightPct(10),
                    color: Colors.green,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
