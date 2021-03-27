import 'condition.dart';
import 'device_screen.dart';

class ConditionBreakpoint<T> extends Condition<T> {
  final DeviceScreenType? screenType;
  final T? value;
  final double? breakpoint;

  const ConditionBreakpoint._({
    this.screenType,
    required Conditional conditional,
    this.value,
    this.breakpoint,
  });

  const ConditionBreakpoint.equals({
    required this.screenType,
    this.value,
  })  : this.breakpoint = null,
        super.equals(value: value);

  const ConditionBreakpoint.largerThan({this.screenType, this.breakpoint, this.value})
      : super.largerThan(value: value);

  const ConditionBreakpoint.smallerThan({this.screenType, this.breakpoint, this.value})
      : super.smallerThan(value: value);

  bool get isNull => breakpoint == null && screenType == null;

  @override
  String toString() =>
      'ConditionBreakpoint( breakpoint: $breakpoint, type: $screenType, condition: $conditional, value: ${value.toString()})';

  @override
  ConditionBreakpoint copyWith({
    DeviceScreenType? type,
    Conditional? condition,
    T? value,
    double? breakpoint,
  }) =>
      ConditionBreakpoint._(
        screenType: type ?? this.screenType,
        conditional: condition ?? this.conditional,
        value: value ?? this.value,
        breakpoint: breakpoint ?? this.breakpoint,
      );
}
