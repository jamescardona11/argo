import 'package:argo/src/theme/i_theme_data_rule.dart';
import 'package:flutter/widgets.dart';

import 'responsive_information.dart';

typedef RBuilder = Widget Function(BuildContext ctx, ResponsiveInformation info);

typedef RWBuilder = Widget Function(BuildContext ctx, IThemeDataRule themeDataRule);
