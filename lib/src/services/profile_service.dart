///
/// Service managing profiles:
/// - managing loaded profiles in memory
/// - providing quick and convenient access to profiles from UI screens
/// - persisting profiles
///
import 'package:flftrainingapp/models.dart';
import 'application_context.dart';

class ProfileService {
  ///
  /// Get all stored profiles
  ///
  Future<ProfileList> getProfileList() async {
    ProfileList result = new ProfileList();
    result.add(Profile.createNew("Hupfi 1"));
    result.add(Profile.createNew("Hupfi 2"));
    result.add(Profile.createNew("Hupfi 3"));
    return result;
  }
}

// register the service instance in the application context
final ProfileService _g_profileService =
    ApplicationContext().register(ProfileService(), "profileService");
