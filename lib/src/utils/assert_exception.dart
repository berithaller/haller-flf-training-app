///
/// Assertions
/// - to verify conditions during runtime
///
class AssertException implements Exception {
  final String message;

  final Exception cause;

  /// Constructor
  /// - message, optional parameter defaulting to null
  /// - cause, optional parameter defaulting ot null
  ///
  /// See
  /// - https://stackoverflow.com/questions/52449508/constructor-optional-params
  AssertException([message, cause])
      : this.message = message,
        this.cause = cause;

  @override
  String toString() {
    String result;

    if (message != null)
      result = message;
    else
      result = "";

    if (cause != null) result += ": " + cause.toString();

    return result;
  }
}
