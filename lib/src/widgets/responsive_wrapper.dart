import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/screen_breakpoints.dart';
import '../theme/responsive_theme.dart';
import '../theme/theme_data_rule.dart';
import '../theme/theme_rule.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';

typedef RWBuilder = Widget Function(BuildContext context, IThemeDataRule themeDataRule);

class ResponsiveWrapper extends StatelessWidget {
  final Widget? child;
  final ScreenBreakpoints globalBreakpoints;
  final ResponsiveTheme? responsiveTheme;
  final ThemeRule themeRule;
  final RWBuilder? builder;

  const ResponsiveWrapper({
    Key? key,
    required this.child,
    this.globalBreakpoints = defaultBreakPoints,
    this.themeRule = ThemeRule.light,
    this.responsiveTheme,
  })  : builder = null,
        super(key: key);

  const ResponsiveWrapper.builder({
    Key? key,
    required this.builder,
    this.globalBreakpoints = defaultBreakPoints,
    this.themeRule = ThemeRule.light,
    this.responsiveTheme,
  })  : child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    IThemeDataRule themeData = getThemeDataFromCondition(context);
    return IWResponsiveWrapper(
      child: child != null
          ? Theme(data: themeData.getThemeByRule(themeRule), child: child!)
          : builder!(context, themeData),
      globalBreakpoints: globalBreakpoints,
      themeRule: themeRule,
    );
  }

  IThemeDataRule getThemeDataFromCondition(BuildContext context) {
    final size = MediaQuery.of(context).size;
    IThemeDataRule themeData = DefaultThemeDataRure();

    if (responsiveTheme != null) {
      if (responsiveTheme!.type == ConditionType.conditions) {
        themeData = valueFromListCondition<IThemeDataRule>(
          currentSize: size,
          conditions: responsiveTheme!.changeWhen!,
          breakpoints: globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      } else {
        themeData = valueFromCondition<IThemeDataRule>(
          currentSize: size,
          conditionScreen: responsiveTheme!.conditionScreen!,
          breakpoints: globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      }
    }

    return themeData;
  }
}

@immutable
class IWResponsiveWrapper extends InheritedWidget {
  final ScreenBreakpoints globalBreakpoints;
  final ThemeRule themeRule;

  const IWResponsiveWrapper({
    Key? key,
    required Widget child,
    this.globalBreakpoints = defaultBreakPoints,
    this.themeRule = ThemeRule.light,
  }) : super(key: key, child: child);

  static IWResponsiveWrapper? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<IWResponsiveWrapper>();

  @override
  bool updateShouldNotify(IWResponsiveWrapper oldWidget) => false;
}
