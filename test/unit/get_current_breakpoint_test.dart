import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/get_current_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('Utils getCurrentBreakpoints', () {
    test('GetValue default', () {
      final current = getCurrentBreakPoints(context: MockBuildContext());

      expect(current, defaultBreakPoints);
    });

    test('GetValue local', () {
      final sb = ScreenBreakpoints(
        mobile: 450,
        tablet: 780,
        desktop: 1201,
      );

      final current = getCurrentBreakPoints(
        context: MockBuildContext(),
        local: sb,
      );

      expect(current, sb);
    });

    // testWidgets('Get CurrentBreakpoint from global values', (WidgetTester tester) async {
    //   final sb = ScreenBreakpoints(
    //     mobile: 450,
    //     tablet: 780,
    //     desktop: 1201,
    //   );

    //   final widget = MaterialApp(
    //     home: Builder(builder: (BuildContext context) {
    //       return ResponsiveWrapper.builder(
    //         globalBreakpoints: sb,
    //         builder: (BuildContext context, IThemeDataRule themeDataRule) {
    //           final current = getCurrentBreakPoints(context: context);
    //           print(current.toString());

    //           // expect(current, sb);
    //           return const SizedBox();
    //         },
    //       );
    //     }),
    //   );

    //   await tester.pumpWidget(widget);
    // });
  });
}
