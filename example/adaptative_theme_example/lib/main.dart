import 'package:adaptative_theme_example/home_view.dart';
import 'package:adaptative_theme_example/theme/theme_mobile.dart';
import 'package:adaptative_theme_example/theme/theme_web.dart';
import 'package:argo/argo.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ruleTheme = ValueNotifier(ThemeRule.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeRule>(
      valueListenable: ruleTheme,
      builder: (context, newRule, child) {
        return MaterialApp(
          title: 'Adaptative Theme(Argo)',
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveWrapper.builder(
            wrapConfig: WrapperConfig(
              globalBreakpoints: ScreenBreakpoints(
                mobile: 321,
                tablet: 650,
                desktop: 1100,
              ),
              themeRule: newRule,
            ),
            responsiveTheme: ResponsiveTheme.screen(
              conditionScreen: ConditionScreen(
                mobile: MyThemesApp(),
                tablet: MyThemesWeb(),
                desktop: MyThemesWeb(),
              ),
            ),
            builder: (IThemeDataRule themeDataRule, ThemeRule rule) {
              return Theme(
                data: themeDataRule.getThemeByRule(rule: rule),
                child: child!,
              );
            },
          ),
          home: HomeView(
            onChangeTheme: changeRuleTheme,
          ),
        );
      },
    );
  }

  void changeRuleTheme(ThemeRule rule) {
    ruleTheme.value = rule;
  }
}
