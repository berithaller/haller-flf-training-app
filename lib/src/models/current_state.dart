///
/// Holds the current interactive state of the app, such as
/// - the currently selected profile or null
///
import 'package:flutter/foundation.dart';
import 'package:flftrainingapp/models.dart';

class CurrentState extends ChangeNotifier {
  /// Contains the currently selected profile, but is initially null.
  /// The object reference shall always point to an entry in the profile service's profileList.
  Profile _currentProfile;

  Profile get currentProfile => _currentProfile;
  set currentProfile(Profile newProfile) {
    // if - for whatever reason - we're setting the same profile again,
    // nothing shall happen. I. e. no listeners shall get notified.
    if (_currentProfile != newProfile) {
      _currentProfile = newProfile;
      notifyListeners();
    }
  }
}
