///
/// Data Model: list of profiles.
///
import 'package:flftrainingapp/models.dart';

class ProfileList {
  /// private: list of profiles
  List<Profile> _profiles = [];

  /// @return list of managed profiles
  List<Profile> get profiles => _profiles.toList();

  /// @return some description for the current object
  @override
  String toString() {
    int len = _profiles.length;
    return 'Profiles {$len}';
  }

  /// Add a profile to the profile list
  void add(Profile profile) {
    _profiles.add(profile);
  }
}
