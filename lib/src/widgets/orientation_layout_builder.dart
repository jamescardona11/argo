import 'package:argo/src/models/typedef.dart';
import 'package:argo/src/utils/get_resonsive_information.dart';
import 'package:flutter/widgets.dart';

/// Widget to handle orientation changes
class OrientationLayoutBuilder extends StatelessWidget {
  final RBuilder? landscape;
  final RBuilder portrait;

  const OrientationLayoutBuilder({
    Key? key,
    this.landscape,
    required this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final info = getResponsiveInformation(
          context: context,
          localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        );

        final orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape) {
          if (landscape != null) {
            return landscape!(context, info);
          }
        }
        return portrait(context, info);
      },
    );
  }
}
