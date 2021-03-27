import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import 'theme_data_rule.dart';

class ResponsiveTheme {
  final List<ConditionBreakpoint<IThemeDataRule>>? changeWhen;
  final ConditionScreen<IThemeDataRule>? conditionScreen;
  final ConditionType? type;
  final IThemeDataRule? deafultTheme;

  ResponsiveTheme.screen({
    required this.conditionScreen,
    this.deafultTheme = const DefaultThemeDataRure(),
  })  : type = ConditionType.conditions,
        changeWhen = null;

  ResponsiveTheme.conditions({
    required this.changeWhen,
    this.deafultTheme = const DefaultThemeDataRure(),
  })  : type = ConditionType.conditions,
        conditionScreen = null;
}
