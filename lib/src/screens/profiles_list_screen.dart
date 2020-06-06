///
/// List of Profiles Screen
///
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';
import 'package:flftrainingapp/services.dart';

class ProfilesListScreen extends StatefulWidget {
  @protected
  @override
  State<ProfilesListScreen> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesListScreen> {
  /// reference to the ProfileService
  final ProfileService _profileService =
      ApplicationContext().get(name: "profileService");

  ProfileList _profileList;

  @protected
  @override
  void initState() {
    super.initState();

    // TODO temporary test data
    // Asynchrously fetch all profiles
    // See
    // - https://stackoverflow.com/questions/51901002/is-there-a-way-to-load-async-data-on-initstate-method
    // - https://flutter.institute/run-async-operation-on-widget-creation/
    _profileService.getProfileList().then(
        // anonymous inner function
        (data) {
      setState() {
        _profileList = data;
      }
    }).catchError(
        // anonymous inner function
        (e) {
      setState() {
// TODO add logging and error handling
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("soon ..."),
    );
  }
}
