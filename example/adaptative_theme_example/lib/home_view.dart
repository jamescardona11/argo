import 'package:flutter/material.dart';
import 'package:argo/argo.dart';

class HomeView extends StatelessWidget {
  final Function(ThemeRule) onChangeTheme;

  const HomeView({
    Key? key,
    required this.onChangeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.widthPct(50),
            height: 200,
            color: theme.primaryColor,
            child: Center(
              child: Text(
                context.widthPx > 650 ? 'Soy Desktop Theme' : 'Soy Mobile Theme',
                style: theme.textTheme.headline1,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Change Theme", style: theme.textTheme.headline2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text('Light'),
                onPressed: () {
                  onChangeTheme(ThemeRule.light);
                },
              ),
              TextButton(
                child: Text('Dark'),
                onPressed: () {
                  onChangeTheme(ThemeRule.dark);
                },
              ),
              TextButton(
                child: Text('Custom'),
                onPressed: () {
                  onChangeTheme(ThemeRule.custom);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
