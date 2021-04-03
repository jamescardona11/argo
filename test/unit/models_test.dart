import 'package:argo/src/models/condition.dart';
import 'package:argo/src/models/condition_breakpoint.dart';
import 'package:argo/src/models/condition_screen.dart';
import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/models.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/size_by_platform.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConditionBreakpoint Model', () {
    test('Create an equals breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.equals(
        screenType: DeviceScreen.mobile,
        value: 10.0,
      );

      expect(conditionBreakpoint.conditional, Conditional.EQUALS);
      expect(conditionBreakpoint.screenType, DeviceScreen.mobile);
      expect(conditionBreakpoint.value, 10.0);
    });

    test('Create an largeThan breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.largerThan(
        screenType: DeviceScreen.mobile,
        value: 10.0,
        breakpoint: 20,
      );

      expect(conditionBreakpoint.conditional, Conditional.LARGER_THAN);
      expect(conditionBreakpoint.screenType, DeviceScreen.mobile);
      expect(conditionBreakpoint.value, 10.0);
      expect(conditionBreakpoint.breakpoint, 20.0);
    });

    test('Create an smallerThan breakpoint', () {
      const conditionBreakpoint = ConditionBreakpoint.smallerThan(
        screenType: DeviceScreen.mobile,
        value: 10.0,
        breakpoint: 20.0,
      );

      expect(conditionBreakpoint.conditional, Conditional.SMALLER_THAN);
      expect(conditionBreakpoint.screenType, DeviceScreen.mobile);
      expect(conditionBreakpoint.value, 10.0);
      expect(conditionBreakpoint.breakpoint, 20.0);
    });

    test('Test copywith', () {
      const conditionBreakpoint = ConditionBreakpoint.equals(
        screenType: DeviceScreen.mobile,
        value: 10.0,
      );
      final theCopy = conditionBreakpoint.copyWith(
        breakpoint: 45,
        screenType: DeviceScreen.desktop,
      );

      expect(theCopy.conditional, Conditional.EQUALS);
      expect(theCopy.screenType, DeviceScreen.desktop);
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
      screenBreakpoints = ScreenBreakpoints(
        mobile: 100,
        tablet: 200,
        desktop: 300,
      );
    });

    test('Get DeviceType from Breakpoint', () {
      final mSize = getSizeByPlatform(size, shortestSide: false);
      final dst = DeviceScreenX.fromBreakpoint(mSize, screenBreakpoints!);
      expect(dst, DeviceScreen.desktop);
    });

    test('Get ScreenValue', () {
      const device = DeviceScreen.tablet;
      final dst = device.getScreenValue(screenBreakpoints!)!.value;

      expect(dst, 200);
    });

    test('ScreenBreakpoints Creation', () {
      screenBreakpoints = ScreenBreakpoints.values(
        mobile: const SBValue.min(100),
        tablet: const SBValue.max(100),
        desktop: const SBValue.min(100),
      );
    });
  });
}
