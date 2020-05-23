/**
 * Data Model: A horse profile.
 */
import 'package:uuid/uuid.dart';

class Profile {
  /** technical ID of the record */
  final String id;

  /** name of the horse */
  String name;

  /** breed of the horse */
  String breed;

  /** birthday of the horse */
  DateTime birthday;

  /** UUID: location of the horse */
  String locationId;

  /** UUID: owner of the horse */
  String ownerId;

  /** just a remarks field */
  String remarks;

  /**
   * Default constructor.
   */
  Profile(this.id, this.name, this.breed, this.birthday, this.locationId,
      this.ownerId, this.remarks);

  /**
   * Factory method to create a new, empty profile
   */
  factory Profile.createNew(String name) =>
      new Profile(Uuid().v4(), name, null, null, null, null, null);

  /**
   * @returns hashcode describing the content of the object
   */
  @override
  int get hashCode =>
      id.hashCode ^
      name?.hashCode ^
      breed?.hashCode ^
      birthday?.hashCode ^
      locationId?.hashCode ^
      ownerId?.hashCode ^
      remarks?.hashCode;

  /**
   * @return <code>true</code> if <i>other</i> is identical or has identical content of the current object.
   */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          id == other.id &&
          name == other.name &&
          breed == other.breed &&
          birthday == other.birthday &&
          locationId == other.locationId &&
          ownerId == other.ownerId &&
          remarks == other.remarks);

  /**
   * @return some description for the current object
   */
  @override
  String toString() {
    return 'Profile {id:$id, name:$name, breed:$breed}';
  }
}
