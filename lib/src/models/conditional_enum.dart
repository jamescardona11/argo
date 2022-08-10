///Has the type of conditionals for the [Condition]
enum Conditional {
  EQUALS,
  SMALLER_THAN,
  LARGER_THAN,
}

/// To separate a class constructor creation by `condition` type in this case,
/// you can choose `screen` to use [ConditionScreen] in thew constructor,
/// you can choose `conditions` to use [ConditionBreakpoint] in thew constructor.
enum ConditionType { screen, conditions }
