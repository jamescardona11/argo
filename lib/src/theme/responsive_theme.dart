import 'package:argo/src/models/models.dart';

import 'default_theme_data.dart';
import 'i_theme_data_rule.dart';

/// {@template responsive_theme}
///
/// Data class to handle the `theme responsive` information, this class may be used from [ResponsiveWrapper]
/// It's used from [ResponsiveWrapper] to get the value for the currentBreakpoints
/// Use different `conditions` to store the themes.
///
/// ```dart
/// ResponsiveTheme.screen(
///    conditionScreen: ConditionScreen(
///      mobile: MyThemesApp(),
///      tablet: MyThemesTablet(),
///      desktop: MyThemesWeb(),
///    ),
///  )
/// ```
///
/// {@endtemplate}
class ResponsiveTheme {
  /// List of conditions using the class [ConditionBreakpoint]
  final List<ConditionBreakpoint<IThemeDataRule>>? changeWhen;

  /// Conditions of screen using the class [ConditionScreen]
  final ConditionScreen<IThemeDataRule>? conditionScreen;

  /// The type of conditions that was invoked
  final ConditionType? type;

  /// We can define a theme for default if there any `condition` that doesn't met
  /// If there isn't a default theme that will use [DefaultThemeDataRule]
  final IThemeDataRule? defaultTheme;

  const ResponsiveTheme.screen({
    required this.conditionScreen,
    this.defaultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.screen,
        changeWhen = null;

  const ResponsiveTheme.conditions({
    required this.changeWhen,
    this.defaultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.conditions,
        conditionScreen = null;
}
