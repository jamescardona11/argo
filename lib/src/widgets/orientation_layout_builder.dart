import 'package:argo/src/models/typedef.dart';
import 'package:argo/src/utils/get_responsive_information.dart';
import 'package:flutter/widgets.dart';

/// {@template orientation_layout_builder}
///
/// The goal of this widget is it create views depending of their `orientation`
///
/// ```dart
/// OrientationLayoutBuilder(
///   portrait: (ctx, info) => PortraitChild(),
///   landscape: (ctx, info) => LandscapeChild(),
/// )
/// ```
///
/// {@endtemplate}
///
class OrientationLayoutBuilder extends StatelessWidget {
  const OrientationLayoutBuilder({
    Key? key,
    this.landscape,
    required this.portrait,
  }) : super(key: key);

  /// Returns [RBuilder] with the responsive information, when the landscape mode
  final RBuilder? landscape;

  /// Returns [RBuilder] with the responsive information, when the portrait mode
  final RBuilder portrait;

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
