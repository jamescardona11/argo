import 'package:argo/src/extensions/responsive_extension.dart';
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
    super.key,
    this.landscape,
    required this.portrait,
  });

  /// Returns [RBuilder] with the responsive information, when the landscape mode
  final RBuilder? landscape;

  /// Returns [RBuilder] with the responsive information, when the portrait mode
  final RBuilder portrait;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final info = GetResponsiveInformation().value(
          context: context,
          screenSize: size,
          localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        );

        if (context.isLandscape && landscape != null) {
          return landscape!(context, info);
        }
        return portrait(context, info);
      },
    );
  }
}
