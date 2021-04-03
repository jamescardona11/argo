import 'screen_model.dart';

/// {@template condition}
///
/// Parent class that has the rules for classes become a [Condition] valid class
/// this class serves as a skeleton for [ConditionsScreen] and [ConditionsBreakpoint].
///
/// {@endtemplate}
abstract class Condition<T> extends ScreenModel<T> {
  /// Type of condition: [EQUALS], [SMALLER_THAN], [LARGER_THAN]
  final Conditional conditional;

  const Condition({
    this.conditional = Conditional.EQUALS,
    T? mobile,
    T? tablet,
    T? desktop,
  }) : super(mobile: mobile, tablet: tablet, desktop: desktop);

  const Condition.equals({T? value, this.conditional = Conditional.EQUALS})
      : super(mobile: value, tablet: value, desktop: value);

  const Condition.largerThan({T? value, this.conditional = Conditional.LARGER_THAN})
      : super(mobile: value, tablet: value, desktop: value);

  const Condition.smallerThan({T? value, this.conditional = Conditional.SMALLER_THAN})
      : super(mobile: value, tablet: value, desktop: value);
}

///Has the type of conditionals for the [Condition]
enum Conditional {
  EQUALS,
  SMALLER_THAN,
  LARGER_THAN,
}

/// To separate a class constructor creation by `condition` type in this case
/// you can choose `screen` to use [ConditionsScreen] in thew constructor
/// you can choose `conditions` to use [ConditionsBreakpoints] in thew constructor
enum ConditionType { screen, conditions }
