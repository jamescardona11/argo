import 'package:argo/src/models/models.dart';
import 'package:flutter/material.dart';

/// {@template responsive_wrapper}
///
/// Widget to configure the responsive for the application.
/// You can use it like global widget or builder widget into `MaterialApp` Widget.
/// Additionally allows to config the [WrapperConfig].
///
/// This widget uses `InheritedWidget` to access from the app to the `globalBreakpoints`
///
/// The basic use:
/// ``` dart
/// MaterialApp(
///  home: ResponsiveWrapper(
///       globalBreakpoints: ScreenBreakpoints(
///         mobile: 321,
///         tablet: 650,
///         desktop: 1100,
///       ),
///       child: Home(),
///    ),
/// )
/// ```
///
/// {@endtemplate}

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.globalBreakpoints = defaultMinimumBreakPoints,
  });

  /// The widget child
  final Widget child;

  /// Global screen breakpoints for the app
  final ScreenBreakpoints globalBreakpoints;

  @override
  Widget build(BuildContext context) {
    return _IWResponsiveWrapper(
      globalBreakpoints: globalBreakpoints,
      child: child,
    );
  }

  static ScreenBreakpoints getGlobalBreakpoints(BuildContext context) =>
      _IWResponsiveWrapper.of(context)?.globalBreakpoints ?? defaultMinimumBreakPoints;

  static ScreenBreakpoints breakpoints(BuildContext context, {ScreenBreakpoints? local}) {
    final global = _IWResponsiveWrapper.of(context)?.globalBreakpoints ?? defaultMinimumBreakPoints;

    // the evaluation for SBValues is for MIN or MAX values.
    final bool isMin = local != null ? local.isMinSBValue : global.isMinSBValue;

    final _mobile = _getDefaultOrValue(DeviceScreen.mobile, isMin, global);
    final _tablet = _getDefaultOrValue(DeviceScreen.tablet, isMin, global);
    final _desktop = _getDefaultOrValue(DeviceScreen.desktop, isMin, global);

    final defaultBreakPoints = isMin ? defaultMinimumBreakPoints : defaultMaximumBreakPoints;

    return defaultBreakPoints.copyWith(
      mobile: local?.mobile ?? _mobile,
      tablet: local?.tablet ?? _tablet,
      desktop: local?.desktop ?? _desktop,
    );
  }

  static SBValue _getDefaultOrValue(DeviceScreen device, bool isMin, ScreenBreakpoints global) {
    late SBValue _global;
    late SBValue _defaultMin;
    late SBValue _defaultMax;
    switch (device) {
      case DeviceScreen.mobile:
        _global = global.mobile!;
        _defaultMin = defaultMinimumBreakPoints.mobile!;
        _defaultMax = defaultMaximumBreakPoints.mobile!;

        break;
      case DeviceScreen.tablet:
        _global = global.tablet!;
        _defaultMin = defaultMinimumBreakPoints.tablet!;
        _defaultMax = defaultMaximumBreakPoints.tablet!;

        break;
      case DeviceScreen.desktop:
        _global = global.desktop!;
        _defaultMin = defaultMinimumBreakPoints.desktop!;
        _defaultMax = defaultMaximumBreakPoints.desktop!;

        break;
    }
    if (isMin == _global.isMinType) {
      return _global;
    } else if (!isMin && _global.isMinType) {
      return _defaultMax;
    } else if (isMin && !_global.isMinType) {
      return _defaultMin;
    }

    return _global;
  }
}

@immutable
class _IWResponsiveWrapper extends InheritedWidget {
  final ScreenBreakpoints globalBreakpoints;

  const _IWResponsiveWrapper({
    required super.child,
    required this.globalBreakpoints,
  });

  static _IWResponsiveWrapper? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_IWResponsiveWrapper>();

  @override
  bool updateShouldNotify(_IWResponsiveWrapper oldWidget) => false;
}
