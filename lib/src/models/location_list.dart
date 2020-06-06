///
/// Data Model: list of locations.
///
import 'package:flftrainingapp/models.dart';
import 'generic_list.dart';

class LocationList extends GenericObservableList<Location> {
  /// @return list of managed locations
  List<Location> get locations => items;

  /// @return some description for the current object
  @override
  String toString() {
    int len = length;
    return 'Locations {$len}';
  }
}
