import 'package:argo/src/models/condition_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_condition_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Utils getValueFromCondition By Screen', () {
    const ScreenBreakpoints screenBreakpoints = ScreenBreakpoints(
      mobile: 320,
      tablet: 700,
      desktop: 1200,
    );

    test('GetValue boolean Size(800, 1000)', () {
      const size = Size(800, 1000);
      const condition = ConditionScreen(
        mobile: 'Mobile',
        tablet: 'Tablet',
        desktop: 'Desktop',
      );

      final value = valueFromConditionByScreen<String>(
        currentSize: size,
        condition: condition,
        breakpoints: screenBreakpoints,
        defaultValue: 'TEST',
      );

      expect(value, 'Tablet');
    });

    test('GetValue boolean Size(1200, 1400)', () {
      const size = Size(1200, 1400);
      const condition = ConditionScreen(
        mobile: true,
        tablet: false,
        desktop: true,
      );

      final value = valueFromConditionByScreen<bool>(
        currentSize: size,
        condition: condition,
        breakpoints: screenBreakpoints,
        defaultValue: false,
      );

      expect(value, true);
    });
  });
}
