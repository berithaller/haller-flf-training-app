///
/// Data Model: A location (place where the horse is located).
///
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'identifiable.dart';

class Location implements IIdentifiable {
  /// technical ID of the record
  final String id;

  /// name of the location
  String name;

  /// postal address of the location
  String address;

  /// geo-coordinates of the location
  Placemark geoCoordinates;

  /// just a remarks field
  String remarks;

  /// Default constructor.
  Location(this.id, this.name, this.address, this.geoCoordinates, this.remarks);

  /// Factory method to create a new, empty profile
  factory Location.createNew(String name) =>
      new Location(Uuid().v4(), name, null, null, null);

  /// @returns hashcode describing the content of the object
  @override
  int get hashCode =>
      id.hashCode ^
      name?.hashCode ^
      address?.hashCode ^
      geoCoordinates?.hashCode ^
      remarks?.hashCode;

  /// @return <code>true</code> if <i>other</i> is identical or has identical content of the current object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          geoCoordinates == other.geoCoordinates &&
          remarks == other.remarks);

  /// @return some description for the current object
  @override
  String toString() {
    return 'Location {id:$id, name:$name}';
  }

  /// Converts the supplied [Map] to an instance of [Location].
  static Location fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' must not be null.');
    }

    final Map<dynamic, dynamic> data = message;

    return Location(
      data['id'],
      data['name'],
      data['address'],
      data['position'] != null
          ? Placemark.fromMap(data['geoCoordinates'])
          : null,
      data['remarks'],
    );
  }

  /// Converts the [Location] instance into a [Map] instance that can be serialized to JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'geoCoordinates': geoCoordinates.toJson(),
        'remarks': remarks
      };
}
