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

    return Container(
      child: Column(
        children: <Widget>[
          Text("TODO - App Title (Home Screen)"),
          welcome,
        ],
      ),
    );
  }
}
