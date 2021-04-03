/// {@template list_extension}
///
/// Extension to iterate and return the first element of the condition `where`
/// or `null` if the condition is not true for all elements
///
/// {@endtemplate}
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
