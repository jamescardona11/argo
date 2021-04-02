import 'package:flutter/material.dart';
import 'package:argo/argo.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Center(
        child: Container(
          width: context.widthPct(50),
          height: 200,
          color: theme.primaryColor,
          child: Text(
            context.isMobile() ? 'Soy Mobile Theme' : 'Soy Desktop Theme',
            style: theme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
