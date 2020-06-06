///
/// Assertions
/// - to verify conditions during runtime
///

import 'assert_exception.dart';

class Assert {
  Assert._();

  static void assertTrue(String message, bool condition) {
    if (!condition)
      throw new AssertException(
          message != null ? message : "Expected to be true");
  }

  static void assertNull(String message, dynamic obj) {
    if (obj != null)
      throw new AssertException(
          message != null ? message : "Expected to be null");
  }

  static void assertNotNull(String message, dynamic obj) {
    if (obj == null)
      throw new AssertException(
          message != null ? message : "Expected to be not null");
  }
}
