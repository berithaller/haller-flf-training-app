import 'package:flftrainingapp/screens.dart';
import 'package:flftrainingapp/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///
/// Home Screen
///


class HomeScreen extends StatefulWidget {
  @protected
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @protected
  @override
  void initState() {
    super.initState();

    // TODO patrick: initialize controller for HomeScreen here.
  }

  /// Create the widget for "Welcome"

  @override
  Widget build(BuildContext context) {
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
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(10),
                color: MyColors.buttoncolor,
                child: Text("Pferd1", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  _push(TrainingPage());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //MaterialPageRoute takes care of creating a new route to be pushed
  //Navigator.of(context) finds a Navigator up in the widget tree and uses it to push the new route
  void _push(var constructor) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => constructor,
    ));
  }
}
