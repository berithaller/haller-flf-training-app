///
/// Robust Date Formatting
///
import 'package:intl/intl.dart';

class NullSafeDateFormat extends DateFormat {

  ///
  /// Offer the super class's constructor
  ///
  @override
  NullSafeDateFormat([String newPattern, String locale])
      : super(newPattern, locale);

  ///
  /// Enhance the super class's method with null-safe behavior.
  ///
  @override
  String format(DateTime date) {
    String result;
    if (date != null)
      result = super.format(date);
    else
      result = "(kein Datum)";

    return result;
  }
}
