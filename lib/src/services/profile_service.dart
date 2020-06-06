///
/// Service managing profiles:
/// - managing loaded profiles in memory
/// - providing quick and convenient access to profiles from UI screens
/// - persisting profiles
///
import 'package:flftrainingapp/models.dart';
import 'application_context.dart';

class ProfileService {
  /// in-memory copy of all known profiles
  final ProfileList _profileList = new ProfileList();

  ///
  /// Get all stored profiles
  ///
  Future<ProfileList> getProfileList() async {
    if (_profileList.isEmpty()) {
      _profileList.add(Profile.createNew("Hupfi 1"));
      _profileList.add(Profile.createNew("Hupfi 2"));
      _profileList.add(Profile.createNew("Hupfi 3"));
    }
    return _profileList;
  }
}

// register the service instance in the application context
final ProfileService _g_profileService =
    ApplicationContext().register(ProfileService(), "profileService");
