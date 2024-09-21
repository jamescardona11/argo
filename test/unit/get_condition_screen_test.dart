import 'package:argo/src/models/condition_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_condition_screen.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

// TODO Wrong test and response values
void main() {
  group('Utils getValueFromCondition By Screen', () {
    final ScreenBreakpoints screenBreakpoints = ScreenBreakpoints(
      mobile: 320,
      tablet: 700,
      desktop: 1200,
    );

    Widget configWidget() {
      return const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: ResponsiveWrapper(
            child: SizedBox(),
          ),
        ),
      );
    }

    testWidgets('GetValue Condition Value from Size(800, 1000)', (WidgetTester tester) async {
      const width = 800;
      const height = 1000;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(configWidget());

      const condition = ConditionScreen(
        mobile: 'Mobile',
        tablet: 'Tablet',
        desktop: 'Desktop',
      );

      BuildContext context = tester.element(find.byType(MaterialApp));

      final value = GetConditionScreen<String>().value(
        context: context,
        size: size,
        condition: condition,
        localBreakpoints: screenBreakpoints,
      );

      expect(value, 'Tablet');
    });

    testWidgets('GetValue boolean Size(1200, 1400)', (WidgetTester tester) async {
      const width = 1200;
      const height = 1400;
      final dpi = tester.view.devicePixelRatio;
      final size = Size(width * dpi, height * dpi);
      tester.view.physicalSize = size;

      await tester.pumpWidget(configWidget());

      BuildContext context = tester.element(find.byType(MaterialApp));

      const condition = ConditionScreen(
        mobile: true,
        tablet: false,
        desktop: true,
      );

      final value = GetConditionScreen<bool>().value(
        context: context,
        size: size,
        condition: condition,
        localBreakpoints: screenBreakpoints,
      );

      expect(value, true);
    });
  });
}
