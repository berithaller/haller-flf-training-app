/**
 * List of Profiles Screen
 */
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';

class ProfilesListScreen extends StatefulWidget
{
  @protected
  @override
  State<ProfilesListScreen> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesListScreen>
{
  /// TODO Patrick: obtain profile list from ProfileService
  ProfileList _profileList = ProfileList();

  @protected
  @override
  void initState()
  {
    super.initState();

    // TODO patrick: initialize controller for HomeScreen here.
    // TODO temporary test data
    _profileList.add( Profile.createNew("Hupfi #1") );
    _profileList.add( Profile.createNew("Hupfi #3") );
    _profileList.add( Profile.createNew("Hupfi #2") );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("soon ..."),
    );
  }

}