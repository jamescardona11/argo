import 'package:argo/src/models/sb_value.dart';

import 'screen_model.dart';

/// {@template screen_breakpoints}
///
/// ScreenBreakpoints are the control points that tells [ResponsiveWrapper] to change the `DeviceScreen`.
/// This is an upper or lower limit depends on how it is configured compared with `Size.width`.
///
///
/// Also it serves to do comparisons with the [Condition] class.
/// [SBValue] save a value that means `Size.width`.
///
/// The basic use is,
/// and for default was set with `SBValue.min`
/// ```dart
/// ScreenBreakpoints(
///   mobile: 320,
///   tablet: 700,
///   desktop: 1200,
/// )
/// ```
///
///
/// Also you can use the constructor `ScreenBreakpoints.values`,
/// to have a bigger control over the [SBValue].
/// ```dart
/// ScreenBreakpoints.values(
///   mobile: const SBValue.max(...),
///   tablet: const SBValue.max(...),
///   desktop: const SBValue.inf(),
/// )
/// ```
/// Sugestion: in order to have a consistance in the behaviour of the app
/// the best is to set the [SBValue] for a [ScreenBreakpoints] in all cases by `min` or `max`,
/// avoiding mixing the types.
///
///
/// {@endtemplate}
class ScreenBreakpoints extends ScreenModel<SBValue> {
  ScreenBreakpoints({
    required double mobile,
    required double tablet,
    required double desktop,
  }) : super(
          mobile: SBValue(mobile),
          tablet: SBValue(tablet),
          desktop: SBValue(desktop),
        );

  ScreenBreakpoints.values({
    required SBValue mobile,
    required SBValue tablet,
    required SBValue desktop,
  })   : assert(mobile.type == tablet.type &&
            mobile.type == desktop.type &&
            tablet.type == desktop.type),
        super(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        );

  const ScreenBreakpoints._defaultValues({
    required SBValue mobile,
    required SBValue tablet,
    required SBValue desktop,
  }) : super(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        );

  bool get isMinSBValue =>
      mobile?.isMinType == true ||
      tablet?.isMinType == true ||
      desktop?.isMinType == true;

  @override
  ScreenBreakpoints copyWith({
    SBValue? mobile,
    SBValue? tablet,
    SBValue? desktop,
  }) =>
      ScreenBreakpoints.values(
        mobile: mobile ?? mobile!,
        tablet: tablet ?? tablet!,
        desktop: desktop ?? desktop!,
      );

  @override
  String toString() => 'ScreenBreakpoints(${super.toString()}';
}

/// Minimum values breakpoints for [DeviceScreen].
///
/// This values are used when `globalBreakpoints` in the [ResponsiveWrapper] aren't set.
const defaultMinimumBreakPoints = ScreenBreakpoints._defaultValues(
  mobile: SBValue.zero(),
  tablet: SBValue.min(700),
  desktop: SBValue.min(1200),
);

/// Maximum values breakpoints for [DeviceScreen].
///
/// This values are used when `globalBreakpoints` in the [ResponsiveWrapper] aren't set.
const defaultMaximumBreakPoints = ScreenBreakpoints._defaultValues(
  mobile: SBValue.max(700),
  tablet: SBValue.max(1200),
  desktop: SBValue.inf(),
);
