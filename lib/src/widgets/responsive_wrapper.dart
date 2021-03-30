import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/theme/default_theme_data.dart';
import 'package:argo/src/utils/get_current_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/screen_breakpoints.dart';
import '../theme/i_theme_data_rule.dart';
import '../theme/responsive_theme.dart';
import '../theme/theme_rule.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';

typedef RWBuilder = Widget Function(BuildContext context, IThemeDataRule themeDataRule);

/// Widget to configure the responsive for the application, you can configure [globalbreakpoints], the [thmeRule]
/// You can use like global widget or builder widget into [MaterialApp] Widget
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
    final IThemeDataRule themeData = getThemeDataFromCondition(context);
    return IWResponsiveWrapper(
      globalBreakpoints: globalBreakpoints,
      themeRule: themeRule,
      child: child != null
          ? Theme(data: themeData.getThemeByRule(themeRule), child: child!)
          : builder!(context, themeData),
    );
  }

  IThemeDataRule getThemeDataFromCondition(BuildContext context) {
    final size = MediaQuery.of(context).size;
    IThemeDataRule themeData = const DefaultThemeDataRule();

    if (responsiveTheme != null) {
      if (responsiveTheme!.type == ConditionType.conditions) {
        themeData = valueFromConditionByBreakpoints<IThemeDataRule>(
          currentSize: size,
          condition: responsiveTheme!.changeWhen!,
          breakpoints: globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      } else {
        themeData = valueFromConditionByScreen<IThemeDataRule>(
          currentSize: size,
          condition: responsiveTheme!.conditionScreen!,
          breakpoints: globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      }
    }

    return themeData;
  }

  ScreenBreakpoints getGlobalBreakpoints(BuildContext context) =>
      getCurrentBreakPoints(context: context);

  ScreenBreakpoints currentBP(
          {required BuildContext context, ScreenBreakpoints? local}) =>
      getCurrentBreakPoints(context: context, local: local);

  bool isMobile(BuildContext context) => DeviceScreenTypeX.fromBreakpoint(
          MediaQuery.of(context).size, getGlobalBreakpoints(context))
      .isMobile();

  bool isTablet(BuildContext context) => DeviceScreenTypeX.fromBreakpoint(
          MediaQuery.of(context).size, getGlobalBreakpoints(context))
      .isTablet();

  bool isDesktop(BuildContext context) => DeviceScreenTypeX.fromBreakpoint(
          MediaQuery.of(context).size, getGlobalBreakpoints(context))
      .isDesktop();
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
