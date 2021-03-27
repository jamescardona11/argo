import 'screen_model.dart';

abstract class Condition<T> extends ScreenModel<T> {
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

enum Conditional {
  EQUALS,
  SMALLER_THAN,
  LARGER_THAN,
}
