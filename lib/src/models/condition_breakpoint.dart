import 'condition.dart';
import 'device_screen.dart';

class ConditionBreakpoint<T> extends Condition<T> {
  final DeviceScreen? screenType;
  final T? value;
  final double? breakpoint;

  const ConditionBreakpoint._({
    this.screenType,
    // ignore: avoid_unused_constructor_parameters
    required Conditional conditional,
    this.value,
    this.breakpoint,
  });

  const ConditionBreakpoint.equals({
    required this.screenType,
    this.value,
  })  : breakpoint = null,
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
  ConditionBreakpoint<T> copyWith({
    DeviceScreen? screenType,
    Conditional? conditional,
    T? value,
    double? breakpoint,
  }) =>
      ConditionBreakpoint<T>._(
        screenType: screenType ?? this.screenType,
        conditional: conditional ?? this.conditional,
        value: value ?? this.value,
        breakpoint: breakpoint ?? this.breakpoint,
      );
}
