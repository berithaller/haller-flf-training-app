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
  @protected
  @override
  void initState()
  {
    super.initState();

    // TODO patrick: initialize controller for HomeScreen here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO - Profiles List Screen")
      ),
    );
  }

}