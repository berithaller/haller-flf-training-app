///
/// Home Screen
///
import 'package:flftrainingapp/models.dart';
import 'package:flftrainingapp/screens.dart';
import 'package:flftrainingapp/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @protected
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final ProfileService _profileService =
      ApplicationContext().get(name: "profileService");

  @protected
  @override
  void initState() {
    super.initState();

    // TODO patrick: initialize controller for HomeScreen here.
  }

  /// Create the widget for "Welcome"

  @override
  Widget build(BuildContext context) {
    // Access to the "current state"
    final CurrentState _currentState = Provider.of<CurrentState>(context);
    assert(_currentState != null);

//ListView does not work, in any way, at all
// no plan what ListBody does, it is not scrollable either, but at least there is no exception
    return Column(
      children: <Widget>[
        SizedBox(height: 80),
        Container(
            child: Text("Willkommen in der Timerapp!",
                style: TextStyle(fontSize: 20, letterSpacing: 1))),
        SizedBox(height: 80),
        Container(
          padding: EdgeInsets.all(15),
          color: MyColors.lightcontrastcolor,
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Text("Jetzt trainieren:",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5)),
              SizedBox(
                height: 15,
              ),
              Text("Bitte ein Pferd auswählen:"),
              getProfileSelector(context, _currentState),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(10),
                color: MyColors.buttoncolor,
                child: getCurrentProfileButton(context, _currentState),
                onPressed: () {
                  // TODO only allow push if _currentState.currentProfile is not null
                  _navigationPush(TrainingPage());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  /// Return a widget representing the currently selected profile.
  ///
  Widget getCurrentProfileButton(
      BuildContext context, CurrentState currentState) {
    assert(currentState != null);

    Widget result;
    final Profile currentProfile = currentState.currentProfile;
    if (currentProfile == null) {
      result = new Text("Bitte zuerst ein Profil anlegen",
          style: TextStyle(color: Colors.red, fontSize: 20));
    } else {
      result = new Text(currentProfile.name + " trainieren",
          style: TextStyle(fontSize: 20));
    }
    return result;
  }

  //
  // Returns a complex widget tree with controls configured to
  // select a single profile as the current one.
  //
  Widget getProfileSelector(BuildContext context, CurrentState currentState) {
    // 1 - get the current profiles
    final ProfileList _profileList = _profileService.getProfileList();

    Widget result;
    if (_profileList.isEmpty) {
      // 1.1 - if there are no widgets, just return a static text telling the user what to do to get new profiles
      result = new Text("Bitte zuerst ein Profil anlegen");
    } else {
      // 1.2 - Create a configured DropdownMenuItem for each profile
      final List<DropdownMenuItem<Profile>> _items = _profileList.items
          .map((e) =>
              new DropdownMenuItem<Profile>(child: new Text(e.name), value: e))
          .toList();

      result = new DropdownButton<Profile>(
        items: _items,
        value: currentState.currentProfile,
        style: TextStyle(color: MyColors.darkcontrastcolor, fontSize: 20),
        underline: Container(
          height: 2,
          color: MyColors.buttoncolor,
        ),
        icon: Icon(Icons.arrow_downward, color: MyColors.buttoncolor,size: 20,),
        onChanged: (final Profile selectedProfile) {
          setState(() {
            currentState.currentProfile = selectedProfile;
          });
        },
      );
    }

    return result;
  }

  //MaterialPageRoute takes care of creating a new route to be pushed
  //Navigator.of(context) finds a Navigator up in the widget tree and uses it to push the new route
  void _navigationPush(var constructor) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => constructor,
    ));
  }
}
