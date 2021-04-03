import 'dart:ui';

import 'package:argo/src/models/condition_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_condition_screen.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('Utils getValueFromCondition By Screen', () {
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
      const width = 800;
      const height = 1000;
      final dpi = tester.binding.window.devicePixelRatio;
      tester.binding.window.physicalSizeTestValue = Size(width * dpi, height * dpi);

      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            const condition = ConditionScreen(
              mobile: 'Mobile',
              tablet: 'Tablet',
              desktop: 'Desktop',
            );

            final value = valueFromConditionByScreen<String>(
              context: context,
              condition: condition,
              localBreakpoints: screenBreakpoints,
              defaultValue: 'TEST',
            );

            expect(value, 'Tablet');

            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('GetValue boolean Size(1200, 1400)', (WidgetTester tester) async {
      const width = 1200;
      const height = 1400;
      final dpi = tester.binding.window.devicePixelRatio;
      tester.binding.window.physicalSizeTestValue = Size(width * dpi, height * dpi);
      await tester.pumpWidget(
        configWidget(
          (BuildContext context) {
            const condition = ConditionScreen(
              mobile: true,
              tablet: false,
              desktop: true,
            );

            final value = valueFromConditionByScreen<bool>(
              context: context,
              condition: condition,
              localBreakpoints: screenBreakpoints,
              defaultValue: false,
            );

            expect(value, true);

            return const SizedBox();
          },
        ),
      );
    });
  });
}
