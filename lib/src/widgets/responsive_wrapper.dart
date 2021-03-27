import '../models/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

class ResponsiveWrapper extends InheritedWidget {
  const ResponsiveWrapper({
    Key? key,
    required Widget child,
    this.globalBreakpoints = defaultBreakPoints,
  }) : super(key: key, child: child);

  final ScreenBreakpoints globalBreakpoints;

  static ResponsiveWrapper? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ResponsiveWrapper>();

  @override
  bool updateShouldNotify(ResponsiveWrapper oldWidget) => false;
}
