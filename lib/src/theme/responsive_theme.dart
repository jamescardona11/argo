import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import 'default_theme_data.dart';
import 'i_theme_data_rule.dart';

/// Data class to handle the theme responsive information, this class only can set with [ResponsiveWrapper]
/// Is used for [ResponsiveWrapper] to get the value for the currentBreakpoints
class ResponsiveTheme {
  final List<ConditionBreakpoint<IThemeDataRule>>? changeWhen;
  final ConditionScreen<IThemeDataRule>? conditionScreen;
  final ConditionType? type;
  final IThemeDataRule? deafultTheme;

  ResponsiveTheme.screen({
    required this.conditionScreen,
    this.deafultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.conditions,
        changeWhen = null;

  ResponsiveTheme.conditions({
    required this.changeWhen,
    this.deafultTheme = const DefaultThemeDataRule(),
  })  : type = ConditionType.conditions,
        conditionScreen = null;
}
