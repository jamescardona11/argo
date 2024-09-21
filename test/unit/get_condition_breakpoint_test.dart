import 'package:argo/src/models/conditions/condition_breakpoint.dart';
import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_condition_breakpoint.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Utils getValueFromConditions By Breakpoint', () {
    final ScreenBreakpoints screenBreakpoints = ScreenBreakpoints(
      mobile: 320,
      tablet: 700,
      desktop: 1200,
    );

    Widget configWidget(WidgetBuilder child) {
      return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: ResponsiveWrapper(
            child: Builder(
              builder: child,
            ),
          ),
        ),
      );
    }

    testWidgets('GetValue boolean Size(800, 1000)', (WidgetTester tester) async {
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreen.mobile,
          value: true,
        ),
        ConditionBreakpoint<bool>.smallerThan(
          screenType: DeviceScreen.desktop,
          value: true,
        ),
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreen.tablet,
          value: false,
        ),
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      const width = 800;
      const height = 1000;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            final value = GetConditionBreakpoint<bool>().value(
              context: context,
              size: size,
              conditions: conditions,
              localBreakpoints: screenBreakpoints,
            );

            expect(value, false);

            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('GetValue boolean Size(1200, 1400)', (WidgetTester tester) async {
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreen.mobile,
          value: true,
        ),
        ConditionBreakpoint<bool>.smallerThan(
          screenType: DeviceScreen.desktop,
          value: true,
        ),
        ConditionBreakpoint<bool>.equals(
          screenType: DeviceScreen.tablet,
          value: false,
        ),
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      const width = 1200;
      const height = 1400;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            final value = GetConditionBreakpoint<bool>().value(
              context: context,
              size: size,
              conditions: conditions,
              localBreakpoints: screenBreakpoints,
            );

            expect(value, true);

            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('GetValue boolean Size(450, 1400) LargeThan', (WidgetTester tester) async {
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.largerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      const width = 450;
      const height = 1400;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            final value = GetConditionBreakpoint<bool>().value(
              context: context,
              size: size,
              conditions: conditions,
              localBreakpoints: screenBreakpoints,
            );

            expect(value, false);

            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('GetValue boolean Size(450, 1400) SmallerThan', (WidgetTester tester) async {
      const List<ConditionBreakpoint<bool>> conditions = [
        ConditionBreakpoint<bool>.smallerThan(
          value: true,
          breakpoint: 950,
        ),
      ];

      const width = 450;
      const height = 1400;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            final value = GetConditionBreakpoint<bool>().value(
              context: context,
              size: size,
              conditions: conditions,
              localBreakpoints: screenBreakpoints,
            );

            expect(value, true);

            return const SizedBox();
          },
        ),
      );
    });
  });
}
