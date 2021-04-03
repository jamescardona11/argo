import 'package:argo/src/models/sb_value.dart';

import '../models/screen_breakpoints.dart';

/// {@template get_current_breakpoint}
///
/// Get the [ScreenBreakpoints] comparing the local, global and default values.
///
///
/// In all cases compare the [SBValue] `type` be the same for all comparisons,
/// and the priority of breakpoints are: Local -> Global -> Default(Min or Max)
///
///
/// {@endtemplate}
ScreenBreakpoints getCurrentBreakPoints({
  required ScreenBreakpoints global,
  ScreenBreakpoints? local,
}) {
  final bool isMin = local != null ? local.isMinSBValue : global.isMinSBValue;

  final _mobile = isMin && global.mobile!.isMinType
      ? global.mobile!
      : defaultMinimumBreakPoints.mobile!;

  final _tablet = isMin && global.tablet!.isMinType
      ? global.mobile!
      : defaultMinimumBreakPoints.tablet!;

  final _desktop = isMin && global.desktop!.isMinType
      ? global.desktop!
      : defaultMinimumBreakPoints.desktop!;

  final defaultBreakPoints =
      isMin ? defaultMinimumBreakPoints : defaultMaximumBreakPoints;

  return defaultBreakPoints.copyWith(
    mobile: _getDoubleValue(local?.mobile, _mobile),
    tablet: _getDoubleValue(local?.tablet, _tablet),
    desktop: _getDoubleValue(local?.desktop, _desktop),
  );
}

SBValue _getDoubleValue(
  SBValue? localBreakpoints,
  SBValue globalBreakpoints,
) {
  return localBreakpoints ?? globalBreakpoints;
}
