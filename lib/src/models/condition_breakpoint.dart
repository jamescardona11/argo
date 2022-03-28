import 'condition.dart';
import 'device_screen.dart';

/// {@template condition_breakpoint}
///
/// Child Class of [Condition],
/// It's goal is to have more modular conditions compared it with differents `breakpoint`
/// we can use this to create more complex conditions.
/// `ConditionBreakpoint` will be use by [valueFromConditionByBreakpoints]
///
/// `ConditionBreakpoint.equals` It is used to create a condition of equality to the CurrentBreakpoint
///
/// `ConditionBreakpoint.largerThan` It is used to create a condition larger than an breakpoint
///
/// `ConditionBreakpoint.smallerThan` It is used to create a condition smaller than an breakpoint
///
/// Mobile, Tablet, Desktop properties from parent class doesn't have a use.
///
///
/// Example
/// ```dart
/// const List<ConditionBreakpoint<bool>> conditions = [
///         ConditionBreakpoint<bool>.equals(
///           screenType: DeviceScreen.mobile,
///           value: true,
///         ),
///         ConditionBreakpoint<bool>.smallerThan(
///           screenType: DeviceScreen.desktop,
///           value: true,
///         ),
///         ConditionBreakpoint<bool>.largerThan(
///           value: true,
///           breakpoint: 950,
///         ),
///       ];
/// ```
///
///
/// {@endtemplate}

class ConditionBreakpoint<T> extends Condition<T> {
  const ConditionBreakpoint._({
    this.screenType,
    // ignore: avoid_unused_constructor_parameters
    required Conditional conditional,
    this.value,
    this.breakpoint,
  }) : super(
          conditional: conditional,
          mobile: value,
          tablet: value,
          desktop: value,
        );

  /// This value tells the condition to look for the `breakpoint` value in the [WrapperConfig]
  /// for the sreen type [mobile], [tablet], [desktop]
  final DeviceScreen? screenType;

  /// It is the return value for the condition if is true
  final T? value;

  /// `Breakpoint` to filter by `Size.with`
  final double? breakpoint;

  const ConditionBreakpoint.equals({
    required this.screenType,
    this.value,
  })  : breakpoint = null,
        super.equals(value);

  const ConditionBreakpoint.largerThan(
      {this.screenType, this.breakpoint, this.value})
      : super.largerThan(value);

  const ConditionBreakpoint.smallerThan(
      {this.screenType, this.breakpoint, this.value})
      : super.smallerThan(value);

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
