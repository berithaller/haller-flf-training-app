/**
 * Home Screen
 */
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  @protected
  @override
  State<HomeScreen> createState() => HomeView();
}

class HomeView extends State<HomeScreen>
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
        title: Text("TODO - App Title (Home Screen)")
      ),
    );
  }

}