import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import 'theme_data_rule.dart';

class ResponsiveTheme {
  final List<ConditionBreakpoint<IThemeDataRule>>? changeWhen;
  final ConditionScreen<IThemeDataRule>? conditionScreen;
  final ConditionType? type;

  ResponsiveTheme.screen(
    this.conditionScreen,
  )   : type = ConditionType.conditions,
        changeWhen = null;

  ResponsiveTheme.conditions(
    this.changeWhen,
  )   : type = ConditionType.conditions,
        conditionScreen = null;
}
