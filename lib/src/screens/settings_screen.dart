import 'package:flftrainingapp/services.dart';
import 'package:flftrainingapp/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Access to the "current state"
    final Settings _settings = Provider.of<Settings>(context);
    assert(_settings != null);

    var slVolume = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.volume_up,
              color: MyColors.darkcontrastcolor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Lautstärke",
              style: TextStyle(color: MyColors.darkcontrastcolor),
            ),
          ],
        ),
        InputSlider(
          activeColor: MyColors.buttoncolor,
          inactiveColor: MyColors.buttoncolor,
          min: 0.0,
          max: 1.0,
          initialValue: _settings.audioVolume,
          onChanged: (double value) {
            setState(() {
              _settings.audioVolume = value;
            });
          },
        )
      ],
    );

    var slPitch = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.tag_faces,
              color: MyColors.darkcontrastcolor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tonhöhe",
              style: TextStyle(color: MyColors.darkcontrastcolor),
            ),
          ],
        ),
        InputSlider(
          activeColor: MyColors.buttoncolor,
          inactiveColor: MyColors.buttoncolor,
          min: 0.0,
          max: 1.0,
          initialValue: _settings.audioPitch,
          onChanged: (double value) {
            setState(() {
              _settings.audioPitch = value;
            });
          },
        )
      ],
    );

    return Center(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        slVolume,
        SizedBox(
          height: 30,
        ),
        slPitch
      ],
    ));
  }
}
