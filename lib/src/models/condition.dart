import 'conditional_enum.dart';
import 'screen_model.dart';

/// {@template condition}
///
/// Parent class that has the rules for classes become a [Condition] valid class,
/// this class serves as a skeleton for [ConditionScreen] and [ConditionBreakpoint].
///
/// {@endtemplate}
abstract class Condition<T> extends ScreenModel<T> {
  /// Type of condition: `EQUALS`, `SMALLER_THAN`, `LARGER_THAN`
  final Conditional conditional;

  const Condition({
    this.conditional = Conditional.EQUALS,
    super.mobile,
    super.tablet,
    super.desktop,
  });

  const Condition.equals(T? value)
      : conditional = Conditional.EQUALS,
        super(mobile: value, tablet: value, desktop: value);

  const Condition.largerThan(T? value)
      : conditional = Conditional.LARGER_THAN,
        super(mobile: value, tablet: value, desktop: value);

  const Condition.smallerThan(T? value)
      : conditional = Conditional.SMALLER_THAN,
        super(mobile: value, tablet: value, desktop: value);
}
