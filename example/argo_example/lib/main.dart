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
    final b = ResponsiveWrapper.of(context);

    print('msg ${b == null}');

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
                  print('constraints.maxWidth1 => ${context.widthPx}');
                  print('constraints.maxHeight1 => ${context.heightPx}');
                  return OrientationExample();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrientationExample extends StatelessWidget {
  const OrientationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('constraints.maxWidth => ${context.widthPx}');
    print('constraints.maxHeight => ${context.heightPx}');

    return Container(
      width: context.widthPct(100),
      height: context.heightPct(10),
      color: Colors.green,
    );
  }
}
