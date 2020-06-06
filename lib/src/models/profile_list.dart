///
/// Data Model: list of profiles.
///
import 'package:flftrainingapp/models.dart';
import 'generic_list.dart';

class ProfileList extends GenericObservableList<Profile> {
  /// @return list of managed profiles
  List<Profile> get profiles => items;

  /// @return some description for the current object
  @override
  String toString() {
    int len = length;
    return 'Profiles {$len}';
  }
}
