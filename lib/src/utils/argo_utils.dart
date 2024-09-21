import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/utils.dart';
import 'package:flutter/widgets.dart';

/// {@template argo_utils}
///
/// In this class we put some useful methods to complement the responsive
/// for more details review the documentation for:
/// - [valueFromConditionByBreakpointsFunc]
/// - [valueFromConditionByScreenFunc]
/// - [getCurrentBreakPointsFunc]
///
///{@endtemplate}
class ArgoUtils {
  static ScreenBreakpoints getCurrentBreakPoints({
    required ScreenBreakpoints global,
    ScreenBreakpoints? local,
  }) =>
      getCurrentBreakPointsFunc(
        global: global,
        local: local,
      );

  static T? valueFromConditionByScreen<T>({
    required BuildContext context,
    required ConditionScreen<T> condition,
    ScreenBreakpoints? localBreakpoints,
  }) =>
      valueFromConditionByScreenFunc<T>(
        context: context,
        condition: condition,
      );
}
