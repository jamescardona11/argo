import 'package:argo/src/models/typedef.dart';
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

/// Widget to configure the responsive for the application, you can configure [globalbreakpoints], the [thmeRule]
/// You can use like global widget or builder widget into [MaterialApp] Widget
class ResponsiveWrapper extends StatelessWidget {
  final dynamic child;

  final ResponsiveTheme? responsiveTheme;
  final WrapperConfig wrapConfig;

  const ResponsiveWrapper({
    Key? key,
    required Widget child,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
  })  : child = child,
        super(key: key);

  const ResponsiveWrapper.builder({
    Key? key,
    required RWBuilder builder,
    this.responsiveTheme,
    this.wrapConfig = const WrapperConfig(),
  })  : child = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final IThemeDataRule themeData = getThemeDataFromCondition(context);
    return _IWResponsiveWrapper(
      wrapConfig: wrapConfig,
      child: returnValue(child, themeData),
    );
  }

  bool _isRWuilder(dynamic data) => data is RWBuilder;

  Widget returnValue(dynamic data, IThemeDataRule themeData) {
    if (_isRWuilder(data)) {
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
