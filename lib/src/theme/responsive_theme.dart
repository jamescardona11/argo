import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import 'default_theme_data.dart';
import 'i_theme_data_rule.dart';

/// {@template responsive_thme}
///
/// Data class to handle the `theme responsive` information, this class may be used from [ResponsiveWrapper]
/// It's used from [ResponsiveWrapper] to get the value for the currentBreakpoints
/// Use differents `conditions` to store the themes.
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

  /// We can define a theme for default if there any `condition` that does'nt met
  /// If there is'nt a default theme thay will use [DefaultThemeDataRule]
  final IThemeDataRule? deafultTheme;

  const ResponsiveTheme.screen({
    required this.conditionScreen,
    this.deafultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.screen,
        changeWhen = null;

  const ResponsiveTheme.conditions({
    required this.changeWhen,
    this.deafultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.conditions,
        conditionScreen = null;
}
