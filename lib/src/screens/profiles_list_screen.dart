///
/// List of Profiles Screen
///
import 'package:flutter/material.dart';
import 'package:flftrainingapp/models.dart';
import 'package:flftrainingapp/utils.dart';
import 'package:flftrainingapp/services.dart';
import 'package:flftrainingapp/src/screens/profile_details_page.dart';
import 'package:intl/intl.dart';

class ProfilesListScreen extends StatefulWidget {
  @protected
  @override
  State<ProfilesListScreen> createState() => _ProfilesListState();
}

abstract class _AbstractProfileAction {
  final ProfileService _profileService;

  final Profile _profile;

  ///
  /// Initializing constructor
  ///
  _AbstractProfileAction(this._profileService, this._profile);

  ///
  /// override to apply an action to the given profile
  ///
  void apply() {}
}

class _ProfileActionDelete extends _AbstractProfileAction {
  _ProfileActionDelete(ProfileService profileService, Profile profile)
      : super(profileService, profile);

  void apply() async {
    final ProfileList profileList = super._profileService.getProfileList();
    profileList.remove(_profile);
  }
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

    _profileList = _profileService.getProfileList();

//    // TODO temporary test data
//    // Asynchronously fetch all profiles
//    // See
//    // - https://stackoverflow.com/questions/51901002/is-there-a-way-to-load-async-data-on-initstate-method
//    // - https://flutter.institute/run-async-operation-on-widget-creation/
//    _profileService.getProfileList().then(
//        // anonymous inner function
//        (data) {
//      setState(
//          // another anonymous inner function
//          () {
//        _profileList = data;
//      });
//    }).catchError(
//        // anonymous inner function
//        (e) {
//      print("profiles_list_screen - catchError");
//
//      setState(() {
//// TODO add logging and error handling
//      });
//    });
  }

  Widget _createProfileCard(Profile profile) {


      var formatter = new NullSafeDateFormat('d.M.y');
      String formatted = formatter.format(profile.birthday);


    String _breed = (profile.breed != null) ? profile.breed + " " : "";
    String _birth = (profile.birthday != null)
        ? "geboren am " + formatted?.toString()
        : "";

    Card _card = new Card(
        color: MyColors.buttoncolor,
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListTile(
            leading: Image.asset('assets/horseSilhouette.webp'),
            title: Text(profile.name),
            subtitle: Text(_breed + _birth),
            isThreeLine: true,
            dense: false,
            onTap: () {
              _navigationPush(ProfileDetailsPage(profile));
            }));

    return new Dismissible(
      key: Key("profile-" + profile.id),
      child: _card,
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          new _ProfileActionDelete(_profileService, profile).apply();
        });

        // Show a snackbar. This snackbar could also contain "Undo" actions.
        final String _name = profile.name;
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text("$_name deleted"),
              new RaisedButton(
                color: MyColors.buttoncolor,
                child: Text(
                  "Undo",
                  style: TextStyle(color: MyColors.darkcontrastcolor),
                ),
                onPressed: () async {
                  final ProfileList _profileList =
                      _profileService.getProfileList();

                  setState(() {
                    _profileList.add(profile);
                  });

                  // TODO how to remove the scaffold and prevent the user from pressing UNDO 10 times?
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              )
            ])));
      },
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
        backgroundColor: MyColors.buttoncolor,
        child: Icon(
          Icons.add,
          color: MyColors.darkcontrastcolor,
        ),
        onPressed: () async {
          _onPressedCreateNewProfile();
        } //when tapped create new Profile
        ));

    //return ListView!!!
    return Column(children: _children);
  }

  ///
  /// Create a new, empty profile and open the ProfileDetailsPage for it.
  ///
  void _onPressedCreateNewProfile() {
    // 1 - create a new, unnamed profile and add it to the ProfileList
    final Profile newProfile = Profile.createNew("Unbenannt");
    final ProfileList profileList = _profileService.getProfileList();
    profileList.add(newProfile);

    // 2 - open the details page for the new profile
    _navigationPush(ProfileDetailsPage(newProfile));
  }

  void _navigationPush(var constructor) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => constructor,
    ));
  }
}
