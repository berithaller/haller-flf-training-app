import 'package:flftrainingapp/services.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkVal = false;
  bool brightVal = false;

  @override
  Widget build(BuildContext context) {
    var cbDarkTheme = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            checkColor: MyColors.darkcontrastcolor,
            activeColor: MyColors.buttoncolor,
            value: darkVal,
            onChanged: (bool value) {
              setState(() {
                darkVal = value;
              });
            }),
        Text("dark Theme")
      ],
    );

    var cbBrightTheme = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            checkColor: MyColors.darkcontrastcolor,
            activeColor: MyColors.buttoncolor,
            value: brightVal,
            onChanged: (bool value) {
              setState(() {
                brightVal = value;
              });
            }),
        Text("bright Theme")
      ],
    );

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        cbDarkTheme,
        cbBrightTheme
      ],
    ));
  }
}
