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
    // Asynchronously fetch all profiles
    // See
    // - https://stackoverflow.com/questions/51901002/is-there-a-way-to-load-async-data-on-initstate-method
    // - https://flutter.institute/run-async-operation-on-widget-creation/
    _profileService.getProfileList().then(
        // anonymous inner function
        (data) {
      setState(
          // another anonymous inner function
          () {
        _profileList = data;
      });
    }).catchError(
        // anonymous inner function
        (e) {
      print("profiles_list_screen - catchError");

      setState(() {
// TODO add logging and error handling
      });
    });
  }

  Widget _createProfileCard(Profile profile) {
    String _breed = (profile.breed != null) ? profile.breed + " " : "";
    String _birth = (profile.birthday != null)
        ? "born on " + profile.birthday?.toString()
        : "";

    return Card(
      color: Colors.blue,
      child: ListTile(
        leading: Image(
          image: NetworkImage(
              "https://cdn.pixabay.com/photo/2018/04/25/22/10/silhouette-3350708_1280.png"),
        ),
        title: Text(profile.name),
        subtitle: Text(_breed + _birth),
        isThreeLine: true,
        dense: false,
        trailing: Icon(Icons.more_vert),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = new List();
    if (_profileList == null)
      _children.add(Text("No data"));
    else {
      dynamic cards =
          _profileList.profiles?.map((p) => _createProfileCard(p))?.toList();
      _children.addAll(cards);
    }

    // add further controls
    _children.add(SizedBox(height: 20));
    _children.add(FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    ));

    //return ListView!!!
    return Column(children: _children);
  }
}
