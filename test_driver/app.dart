/**
 * This is an instrumented version of the main app.
 * <p>
 * It is rigging the main app for integration testing.
 *
 * See
 * https://flutter.dev/docs/cookbook/testing/integration/introduction
 */
import 'package:flutter_driver/driver_extension.dart';
import 'package:haller-flf-training-app/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
