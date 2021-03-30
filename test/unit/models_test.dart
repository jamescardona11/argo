import 'package:argo/src/models/condition.dart';
import 'package:argo/src/models/condition_breakpoint.dart';
import 'package:argo/src/models/condition_screen.dart';
import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConditionBreakpoint Model', () {
    test('Create an equals breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.equals(
        screenType: DeviceScreenType.mobile,
        value: 10.0,
      );

      expect(conditionBreakpoint.conditional, Conditional.EQUALS);
      expect(conditionBreakpoint.screenType, DeviceScreenType.mobile);
      expect(conditionBreakpoint.value, 10.0);
    });

    test('Create an largeThan breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.largerThan(
        screenType: DeviceScreenType.mobile,
        value: 10.0,
        breakpoint: 20,
      );

      expect(conditionBreakpoint.conditional, Conditional.LARGER_THAN);
      expect(conditionBreakpoint.screenType, DeviceScreenType.mobile);
      expect(conditionBreakpoint.value, 10.0);
      expect(conditionBreakpoint.breakpoint, 20.0);
    });

    test('Create an smallerThan breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.smallerThan(
        screenType: DeviceScreenType.mobile,
        value: 10.0,
        breakpoint: 20.0,
      );

      expect(conditionBreakpoint.conditional, Conditional.SMALLER_THAN);
      expect(conditionBreakpoint.screenType, DeviceScreenType.mobile);
      expect(conditionBreakpoint.value, 10.0);
      expect(conditionBreakpoint.breakpoint, 20.0);
    });

    test('Test copywith', () {
      const conditionBreakpoint = ConditionBreakpoint.equals(
        screenType: DeviceScreenType.mobile,
        value: 10.0,
      );
      final theCopy = conditionBreakpoint.copyWith(
        breakpoint: 45,
        screenType: DeviceScreenType.desktop,
      );

      expect(theCopy.conditional, Conditional.EQUALS);
      expect(theCopy.screenType, DeviceScreenType.desktop);
      expect(theCopy.value, 10.0);
      expect(theCopy.breakpoint, 45.0);
    });
  });

  group('ConditionScreen Model', () {
    test('Create an Element without null', () {
      const conditionScreen = ConditionScreen<double>(
        mobile: 10,
        tablet: 20,
        desktop: 30,
      );

      expect(conditionScreen.mobile, 10);
      expect(conditionScreen.tablet, 20);
      expect(conditionScreen.desktop, 30);
    });

    test('Create an Element with null value', () {
      const conditionScreen = ConditionScreen<double>(
        mobile: 10,
        desktop: 30,
      );

      expect(conditionScreen.mobile, 10);
      expect(conditionScreen.tablet, null);
      expect(conditionScreen.desktop, 30);
    });

    test('test copyWith', () {
      const conditionScreen = ConditionScreen<double>(
        mobile: 10,
        desktop: 30,
      );
      final theCopy = conditionScreen.copyWith(
        tablet: 10,
        desktop: 100,
      );

      expect(theCopy.mobile, 10);
      expect(theCopy.tablet, 10);
      expect(theCopy.desktop, 100);
    });
  });
  group('DeviceScreenTypeX Model', () {
    const Size size = Size(500, 1000);
    ScreenBreakpoints? screenBreakpoints;

    setUp(() {
      screenBreakpoints = const ScreenBreakpoints(
        mobile: 100,
        tablet: 200,
        desktop: 300,
      );
    });

    test('Get DeviceType from Size', () {
      final dst = DeviceScreenTypeX.fromSize(size);

      expect(dst, DeviceScreenType.mobile);
    });

    test('Get DeviceType from Breakpoint', () {
      final dst = DeviceScreenTypeX.fromBreakpoint(size, screenBreakpoints!);

      expect(dst, DeviceScreenType.desktop);
    });

    test('Get ScreenValue', () {
      const device = DeviceScreenType.tablet;
      final dst = device.getScreenValue<double>(screenBreakpoints!);

      expect(dst, 200);
    });
  });
}
