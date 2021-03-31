import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/device_screen.dart';
import '../models/wrapper_config.dart';
import '../theme/default_theme_data.dart';
import '../theme/i_theme_data_rule.dart';
import '../theme/responsive_theme.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';

typedef RWBuilder = Widget Function(BuildContext context, IThemeDataRule themeDataRule);

/// Widget to configure the responsive for the application, you can configure [globalbreakpoints], the [thmeRule]
/// You can use like global widget or builder widget into [MaterialApp] Widget
class ResponsiveWrapper extends StatelessWidget {
  final Widget? child;
  final RWBuilder? builder;
  final ResponsiveTheme? responsiveTheme;
  final WrapperConfig wrapConfig;

  const ResponsiveWrapper({
    Key? key,
    required this.child,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
  })  : builder = null,
        super(key: key);

  const ResponsiveWrapper.builder({
    Key? key,
    required this.builder,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
  })  : child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final IThemeDataRule themeData = getThemeDataFromCondition(context);
    return _IWResponsiveWrapper(
      wrapConfig: wrapConfig,
      child: child != null
          ? Theme(data: themeData.getThemeByRule(wrapConfig.themeRule), child: child!)
          : builder!(context, themeData),
    );
  }

  IThemeDataRule getThemeDataFromCondition(BuildContext context) {
    IThemeDataRule themeData = const DefaultThemeDataRule();

    if (responsiveTheme != null) {
      if (responsiveTheme!.type == ConditionType.conditions) {
        themeData = valueFromConditionByBreakpoints<IThemeDataRule>(
          context: context,
          condition: responsiveTheme!.changeWhen!,
          localBreakpoints: wrapConfig.globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      } else {
        themeData = valueFromConditionByScreen<IThemeDataRule>(
          context: context,
          condition: responsiveTheme!.conditionScreen!,
          localBreakpoints: wrapConfig.globalBreakpoints,
          defaultValue: responsiveTheme!.deafultTheme ?? themeData,
        );
      }
    }

    return themeData;
  }

  static WrapperConfig getWrapperConfig(BuildContext context) =>
      _IWResponsiveWrapper.of(context)?.wrapConfig ?? const WrapperConfig();

  static bool isMobile(BuildContext context) => _getDeviceScreen(context).isMobile();

  static bool isTablet(BuildContext context) => _getDeviceScreen(context).isTablet();

  static bool isDesktop(BuildContext context) => _getDeviceScreen(context).isDesktop();

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
