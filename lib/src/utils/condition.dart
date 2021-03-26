import 'device_screen_type.dart';

class Condition<T> {
  final DeviceScreenType? screenType;
  final Conditional? conditional;
  final T? value;
  final double? breakpoint;

  const Condition._({
    this.screenType,
    this.conditional,
    this.value,
    this.breakpoint,
  });

  const Condition.equals({required DeviceScreenType type, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = null,
        this.conditional = Conditional.EQUALS;

  const Condition.largerThan({DeviceScreenType? type, double? breakpoint, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = breakpoint,
        this.conditional = Conditional.LARGER_THAN;

  const Condition.smallerThan({DeviceScreenType? type, double? breakpoint, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = breakpoint,
        this.conditional = Conditional.SMALLER_THAN;

  Condition copyWith({
    DeviceScreenType? type,
    Conditional? condition,
    T? value,
    double? breakpoint,
  }) =>
      Condition._(
        screenType: type ?? this.screenType,
        conditional: condition ?? this.conditional,
        value: value ?? this.value,
        breakpoint: breakpoint ?? this.breakpoint,
      );

  @override
  String toString() =>
      'Condition(' +
      'breakpoint: ' +
      breakpoint.toString() +
      ', type: ' +
      screenType.toString() +
      ', condition: ' +
      conditional.toString() +
      ', value: ' +
      value.toString() +
      ')';

  int sort(Condition a, Condition b) {
    if (a.breakpoint == b.breakpoint) return 0;
    return (a.breakpoint! < b.breakpoint!) ? -1 : 1;
  }
}

enum Conditional {
  EQUALS,
  SMALLER_THAN,
  LARGER_THAN,
}
