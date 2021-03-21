import 'package:argo/src/utils/screen_breakpoints.dart';

import 'device_screen_type.dart';

class Condition {
  final DeviceScreenType? type;
  final Conditional? condition;

  final bool? value;
  final double? breakpoint;

  const Condition._({
    this.type,
    this.condition,
    this.value,
    this.breakpoint,
  });

  const Condition.equals({required DeviceScreenType type})
      : this.type = type,
        this.value = true,
        this.breakpoint = null,
        this.condition = Conditional.EQUALS;

  const Condition.largerThan({required DeviceScreenType type, double? breakpoint})
      : this.type = type,
        this.value = true,
        this.breakpoint = breakpoint,
        this.condition = Conditional.LARGER_THAN;

  const Condition.smallerThan({required DeviceScreenType type, double? breakpoint})
      : this.type = type,
        this.value = true,
        this.breakpoint = breakpoint,
        this.condition = Conditional.SMALLER_THAN;

  Condition copyWith({
    DeviceScreenType? type,
    Conditional? condition,
    bool? value,
    double? breakpoint,
  }) =>
      Condition._(
        type: type ?? this.type,
        condition: condition ?? this.condition,
        value: value ?? this.value,
        breakpoint: breakpoint ?? this.breakpoint,
      );

  @override
  String toString() =>
      'Condition(' +
      'breakpoint: ' +
      breakpoint.toString() +
      ', type: ' +
      type.toString() +
      ', condition: ' +
      condition.toString() +
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

void conditionValue(ScreenBreakpoints breakpoints, List<Condition> valueWhen) {}
