import 'package:argo/argo.dart';

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
  // the evaluation for SBValues is for MIN or MAX values.
  final bool isMin = local != null ? local.isMinSBValue : global.isMinSBValue;

  final _mobile = _getDefaultOrValue(DeviceScreen.mobile, isMin, global);
  final _tablet = _getDefaultOrValue(DeviceScreen.tablet, isMin, global);
  final _desktop = _getDefaultOrValue(DeviceScreen.desktop, isMin, global);

  final defaultBreakPoints =
      isMin ? defaultMinimumBreakPoints : defaultMaximumBreakPoints;

  return defaultBreakPoints.copyWith(
    mobile: _getDoubleValue(local?.mobile, _mobile),
    tablet: _getDoubleValue(local?.tablet, _tablet),
    desktop: _getDoubleValue(local?.desktop, _desktop),
  );
}

SBValue _getDefaultOrValue(
    DeviceScreen device, bool isMin, ScreenBreakpoints global) {
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

SBValue _getDoubleValue(
  SBValue? localBreakpoints,
  SBValue globalBreakpoints,
) {
  return localBreakpoints ?? globalBreakpoints;
}
