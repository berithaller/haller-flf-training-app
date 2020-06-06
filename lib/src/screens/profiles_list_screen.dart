/**
 * List of Profiles Screen
 */
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';

class ProfilesListScreen extends StatefulWidget {
  @protected
  @override
  State<ProfilesListScreen> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesListScreen> {
  /// TODO Patrick: obtain profile list from ProfileService
  ProfileList _profileList = ProfileList();

  @protected
  @override
  void initState() {
    super.initState();

    // TODO patrick: initialize controller for HomeScreen here.
    // TODO temporary test data
    _profileList.add(Profile.createNew("Hupfi #1"));
    _profileList.add(Profile.createNew("Hupfi #3"));
    _profileList.add(Profile.createNew("Hupfi #2"));
  }

  Widget _createCard(String title, String subtitle) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        leading: Image(
          image: NetworkImage(
              "https://cdn.pixabay.com/photo/2018/04/25/22/10/silhouette-3350708_1280.png"),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        dense: false,
        trailing: Icon(Icons.more_vert),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return ListView!!!
    return Column(
      children: [

        _createCard("Pferdename2", "Andalusier"),
        _createCard("Pferdename1", "Haflinger"),
        SizedBox(height: 20),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }
}
