///
/// Data Model: A horse profile.
///
import 'package:uuid/uuid.dart';
import 'identifiable.dart';

class Profile implements IIdentifiable {
  /// technical ID of the record */
  final String id;

  /// name of the horse */
  String name;

  /// breed of the horse */
  String breed;

  /// birthday of the horse */
  DateTime birthday;

  /// UUID: location of the horse */
  String locationId;

  /// UUID: conact person of the horse */
  String contactId;

  /// just a remarks field */
  String remarks;

  /// Default constructor.
  Profile(this.id, this.name, this.breed, this.birthday, this.locationId,
      this.contactId, this.remarks);

  /// Factory method to create a new, empty profile
  factory Profile.createNew(String name) =>
      new Profile(Uuid().v4(), name, null, null, null, null, null);

  /// @returns hashcode describing the content of the object
  @override
  int get hashCode =>
      id.hashCode ^
      name?.hashCode ^
      breed?.hashCode ^
      birthday?.hashCode ^
      locationId?.hashCode ^
      contactId?.hashCode ^
      remarks?.hashCode;

  /// @return <code>true</code> if <i>other</i> is identical or has identical content of the current object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          id == other.id &&
          name == other.name &&
          breed == other.breed &&
          birthday == other.birthday &&
          locationId == other.locationId &&
          contactId == other.contactId &&
          remarks == other.remarks);

  /// @return some description for the current object
  @override
  String toString() {
    return 'Profile {id:$id, name:$name, breed:$breed}';
  }

  /// Converts the supplied [Map] to an instance of [Profile].
  static Profile fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' must not be null.');
    }

    final Map<dynamic, dynamic> data = message;

    return Profile(
      data['id'],
      data['name'],
      data['breed'],
      data['birthday'],
      data['locationId'],
      data['contactId'],
      data['remarks'],
    );
  }

  /// Converts the [Profile] instance into a [Map] instance that can be serialized to JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'breed': breed,
        'birthday': birthday,
        'locationId': locationId,
        'contactId': contactId,
        'remarks': remarks
      };
}
