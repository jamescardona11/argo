import 'package:argo/src/models/typedef.dart';
import 'package:flutter/material.dart';

import '../models/condition.dart';
import '../models/device_screen.dart';
import '../models/wrapper_config.dart';
import '../theme/default_theme_data.dart';
import '../theme/i_theme_data_rule.dart';
import '../theme/responsive_theme.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';

/// {@template responsive_wrapper}
///
/// Widget to configure the responsive for the application.
/// You can use it like global widget or builder widget into `MaterialApp` Widget.
/// Additionally allows to config the [WrapperConfig].
/// You can make the manage for `Responsive Theme`
///
/// This widget uses `InheritedWidget` to access from the app to the `wrapConfig`
///
/// The basic use:
/// ``` dart
/// MaterialApp(
///  home: ResponsiveWrapper(
///       wrapConfig: WrapperConfig(
///         globalBreakpoints: ScreenBreakpoints(
///           mobile: 321,
///           tablet: 650,
///         desktop: 1100,
///         ),
///       ),
///       child: Home(),
///    ),
/// )
/// ```
/// Also [ResponsiveWrapper] can be the parent of `MaterialApp`
///
/// To config `Responsive Theme` use the `responsiveTheme`
///
///
/// {@endtemplate}

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    Key? key,
    required Widget child,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
    // this.debugLogDiagnostics = false,
  })  : child = child,
        super(key: key);

  const ResponsiveWrapper.builder({
    Key? key,
    required RWBuilder builder,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
    // this.debugLogDiagnostics = false,
  })  : child = builder,
        super(key: key);

  /// The widget child
  final dynamic child;

  /// Class to manage and handle the app themes
  final ResponsiveTheme? responsiveTheme;

  /// The global configuration of `ResponsiveWrapper`
  final WrapperConfig wrapConfig;

  /// debug logs
  // final bool debugLogDiagnostics;

  @override
  Widget build(BuildContext context) {
    final IThemeDataRule themeData = getThemeDataFromCondition(context);

    return _IWResponsiveWrapper(
      wrapConfig: wrapConfig,
      child: returnValue(child, themeData),
    );
  }

  bool _isRBuilder(dynamic data) => data is RWBuilder;

  Widget returnValue(dynamic data, IThemeDataRule themeData) {
    if (_isRBuilder(data)) {
      return (data as RWBuilder)(themeData, wrapConfig.themeRule);
    }

    return responsiveTheme != null
        ? Theme(
            data: themeData.getThemeByRule(wrapConfig.themeRule),
            child: data as Widget,
          )
        : data as Widget;
  }

  IThemeDataRule getThemeDataFromCondition(BuildContext context) {
    IThemeDataRule themeData = const DefaultThemeDataRule();

    if (responsiveTheme != null) {
      if (responsiveTheme!.type == ConditionType.conditions) {
        themeData = valueFromConditionByBreakpoints<IThemeDataRule>(
          context: context,
          condition: responsiveTheme!.changeWhen!,
          localBreakpoints: wrapConfig.globalBreakpoints,
          defaultValue: responsiveTheme!.defaultTheme ?? themeData,
        )!;
      } else {
        themeData = valueFromConditionByScreen<IThemeDataRule>(
          context: context,
          condition: responsiveTheme!.conditionScreen!,
          localBreakpoints: wrapConfig.globalBreakpoints,
          defaultValue: responsiveTheme!.defaultTheme ?? themeData,
        )!;
      }
    }

    return themeData;
  }

  static WrapperConfig getWrapperConfig(BuildContext context) =>
      _IWResponsiveWrapper.of(context)?.wrapConfig ?? const WrapperConfig();

  static bool isMobile(BuildContext context) =>
      _getDeviceScreen(context).isMobile();

  static bool isTablet(BuildContext context) =>
      _getDeviceScreen(context).isTablet();

  static bool isDesktop(BuildContext context) =>
      _getDeviceScreen(context).isDesktop();

  static DeviceScreen _getDeviceScreen(BuildContext context) {
    final rw = getWrapperConfig(context);
    return DeviceScreenX.fromBreakpoint(
        rw.getDeviceWidth(MediaQuery.of(context).size), rw.globalBreakpoints);
  }
}

@immutable
class _IWResponsiveWrapper extends InheritedWidget {
  final WrapperConfig wrapConfig;

  const _IWResponsiveWrapper({
    Key? key,
    required Widget child,
    required this.wrapConfig,
  }) : super(key: key, child: child);

  static _IWResponsiveWrapper? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_IWResponsiveWrapper>();

  @override
  bool updateShouldNotify(_IWResponsiveWrapper oldWidget) => false;
}
