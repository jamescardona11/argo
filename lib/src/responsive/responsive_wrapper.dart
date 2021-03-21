import 'package:flutter/widgets.dart';

class ResponsiveWrapper extends InheritedWidget {
  static ResponsiveWrapper? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ResponsiveWrapper>();

  const ResponsiveWrapper({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final String successMessage = 'Some message';

  @override
  bool updateShouldNotify(ResponsiveWrapper oldWidget) => false;
}
