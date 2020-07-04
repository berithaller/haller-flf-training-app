///
/// Service managing profiles:
/// - managing loaded profiles in memory
/// - providing quick and convenient access to profiles from UI screens
/// - persisting profiles
///
import 'package:flftrainingapp/models.dart';

class ProfileService {
  /// in-memory copy of all known profiles
  final ProfileList _profileList = new ProfileList();

  void loadExampleProfiles() async {
    if (_profileList.isEmpty) {
      _profileList.add(Profile.createNew("Hupfi 1"));
      _profileList.add(Profile.createNew("Hupfi 2"));
      _profileList.add(Profile.createNew("Hupfi 3"));
    }
  }

  ///
  /// Get all stored profiles.
  /// Never returns null, but an empty list.
  ///
  ProfileList getProfileList() {
    return _profileList;
  }
}
