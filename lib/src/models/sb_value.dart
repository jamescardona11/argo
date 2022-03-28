/// {@template responsive_information}
///
/// [SBValue] class to stores the values of [ScreenBreakpoints].
/// [SBValue] save a value that means limit for a screen breakpoint is similar to `Size.width`.
/// We can use differents `type` of values `min`, `max`,
/// The types serves to do comparations between all the differents [ScreenBreakpoints]
///
/// Sugestion: in order to have a consistance in the behaviour of the app
/// the best is to set the [SBValue] for a [ScreenBreakpoints] in all cases by `min` or `max`,
/// avoiding mixing the types.
///
/// [min]: refers to the lower limit for the width of screen.
///
/// [max]: refers to the upper limit for the width of screen.
///
/// Example
/// mobile: SBValue.max(500) it means the maximum `width` to mobile type is 500.
/// desktop: SBValue.min(1200) it means the minimun `width` to desktop type is 1200.
///
///
/// Could be use `SBValue.zero` for indicate the minimum value in 0.
///
/// Could be use `SBValue.inf` for indicate the maximum value in double.infinity.
///
/// {@endtemplate}
class SBValue {
  final double value;
  final _SBType type;

  factory SBValue(double? value) => SBValue.min(value ?? 0);

  const SBValue.min(this.value) : type = _SBType.min;

  const SBValue.max(this.value) : type = _SBType.max;

  const SBValue.zero()
      : value = 0,
        type = _SBType.min;

  const SBValue.inf()
      : value = double.infinity,
        type = _SBType.max;

  bool get isMinType => type == _SBType.min;
  bool get isMaxType => type == _SBType.max;

  @override
  String toString() {
    // final strType = isMinType ? _SBType.min.toString() : _SBType.max.toString();

    return 'Value: $value';
  }
}

/// Enum for the SBValue types
enum _SBType {
  min,
  max,
}
