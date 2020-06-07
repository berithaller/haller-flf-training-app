import 'package:flutter/cupertino.dart';

///
/// Home Screen
///
import 'package:flutter/material.dart';

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

  Widget _createWelcome() {
    final Widget welcome = Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          backgroundBlendMode: BlendMode.colorBurn,
          border: Border.all(color: Colors.blue, width: 2)),
      child: Column(
        children: <Widget>[Text("Welcome"), Icon(Icons.face)],
      ),
    );
    return welcome;
  }

  @override
  Widget build(BuildContext context) {
    var welcome = _createWelcome();

//ListView does not work, in any way, at all
// no plan what ListBody does, it is not scrollable either, but at least there is no exception
    return Column(
      children: <Widget>[
        Container(
            child: Text("Willkommen in der Timerapp!",
                style: TextStyle(fontSize: 20, letterSpacing: 1))),
        SizedBox(height: 80),
        Container(
          padding: EdgeInsets.all(15),
          color: Colors.amberAccent,
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Text("Jetzt trainieren:",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5)),
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text("Pferd1", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  //Route for the training page has to be here, it has to be initialised in the main file
                  Navigator.pushNamed(context, '/training_page');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
