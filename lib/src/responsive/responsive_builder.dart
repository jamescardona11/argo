import 'package:argo/src/utils/device_screen_type.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:argo/src/utils/sizing_information.dart';
import 'package:flutter/widgets.dart';

typedef RBuilder = Widget Function(
    BuildContext context, SizingInformation sizingInformation);

class ResponsiveBuilder extends StatelessWidget {
  final RBuilder builder;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
    this.breakpoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      final bp = getBreakPoints(context, breakpoints);
      final size = MediaQuery.of(context).size;

      var sizingInformation = SizingInformation(
        deviceScreenType: DeviceScreenTypeX.getDeviceType(size, bp),
        screenSize: size,
        localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder(context, sizingInformation);
    });
  }
}
