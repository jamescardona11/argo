import 'package:argo/src/models/condition_breakpoint.dart';
import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_condition_breakpoint.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Utils getValueFromConditions By Breakpoint', () {
    const ScreenBreakpoints screenBreakpoints = ScreenBreakpoints(
      mobile: 320,
      tablet: 700,
      desktop: 1200,
    );

    test('GetValue boolean Size(800, 1000)', () {
      const size = Size(800, 1000);
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreenType.mobile,
          value: true,
        ),
        ConditionBreakpoint<bool>.smallerThan(
          screenType: DeviceScreenType.desktop,
          value: true,
        ),
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreenType.tablet,
          value: false,
        ),
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      final value = valueFromConditionByBreakpoints<bool>(
        currentSize: size,
        condition: conditions,
        breakpoints: screenBreakpoints,
        defaultValue: true,
      );

      expect(value, false);
    });

    test('GetValue boolean Size(1200, 1400)', () {
      const size = Size(1200, 1400);
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreenType.mobile,
          value: true,
        ),
        ConditionBreakpoint<bool>.smallerThan(
          screenType: DeviceScreenType.desktop,
          value: true,
        ),
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreenType.tablet,
          value: false,
        ),
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      final value = valueFromConditionByBreakpoints<bool>(
        currentSize: size,
        condition: conditions,
        breakpoints: screenBreakpoints,
        defaultValue: true,
      );

      expect(value, true);
    });

    test('GetValue boolean Size(450, 1400) LargeThan', () {
      const size = Size(450, 1400);
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      final value = valueFromConditionByBreakpoints<bool>(
        currentSize: size,
        condition: conditions,
        breakpoints: screenBreakpoints,
        defaultValue: false,
      );

      expect(value, false);
    });

    test('GetValue boolean Size(450, 1400) SmallerThan', () {
      const size = Size(450, 1400);
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.smallerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      final value = valueFromConditionByBreakpoints<bool>(
        currentSize: size,
        condition: conditions,
        breakpoints: screenBreakpoints,
        defaultValue: false,
      );

      expect(value, true);
    });
  });
}
