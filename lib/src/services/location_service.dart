///
/// Service managing locations:
/// - managing loaded locations in memory
/// - providing quick and convenient access to locations from UI screens
/// - persisting locations
///
import 'package:flftrainingapp/models.dart';
import 'application_context.dart';

class LocationService {
  /// in-memory copy of all known locations
  final LocationList _locationList = new LocationList();

  ///
  /// Get all stored locations
  ///
  Future<LocationList> getLocationList() async {
    if (_locationList.isEmpty) {
      _locationList.add(Location.createNew("Koppel Oberbaumgarten"));
      _locationList.add(Location.createNew("Eriskirch, Garten"));
      _locationList.add(Location.createNew("Pferdehotel Zum Nassen Pony"));
    }
    return _locationList;
  }
}

// register the service instance in the application context
final LocationService _g_locationService =
    ApplicationContext().register(LocationService(), "locationService");
