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
