import 'package:flftrainingapp/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flftrainingapp/models.dart';

class ProfileDetailsPage extends StatefulWidget {
  /// the profile that is currently displayed / edited
  final Profile _profile;

  ///
  /// Initializing constructor
  ///
  ProfileDetailsPage(this._profile);

  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState(_profile);
}

typedef DisposeFn = void Function();

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final Key keyName = Key("KEY_Name");
  final Key keyBreed = Key("KEY_Breed");
  final Key keyRemarks = Key("KEY_Remarks");

  /// the profile that is currently displayed / edited
  final Profile _profile;

  /// List of dispose callbacks
  List<DisposeFn> _disposeList = [];

  ///
  /// Initializing constructor
  ///
  _ProfileDetailsPageState(this._profile);

  Widget build(BuildContext context) {
    final String _profileName =
        (_profile != null) ? _profile.name : "A horse with no name";

    return Scaffold(
        appBar: AppBar(title: Text(_profileName)),
        body: new Column(children: <Widget>[
          createTextField(keyName, "Name", _profile.name, _onChangeName),
          createTextField(keyBreed, "Breed", _profile.breed, _onChangeBreed),
          createTextField(
              keyRemarks, "Remarks", _profile.remarks, _onChangeRemarks),
        ])
        //Inputs: Name, Trainingslevel, Alter, Rasse, Besitzer, Standort, Sonstiges
        );
  }

  ///
  /// Perform cleanup when the current page is destroyed
  ///
  @override
  void dispose() {
    _disposeList.forEach((fn) => fn());
    super.dispose();
  }

  Widget createTextField(Key _key, String title, String _value,
      void callbackSetValue(Key k, String s)) {
    final TextEditingController _controller =
        new TextEditingController(text: _value);

    _disposeList.add(_controller.dispose);

    final TextField _textField = TextField(
      maxLength: 64,
      maxLines: 1,
      key: _key,
      autofocus: true,
      controller: _controller,
      style: TextStyle(
        color: MyColors.lightcontrastcolor,
        fontSize: 20,
      ),
      decoration: new InputDecoration(
        labelText: title,
        labelStyle: new TextStyle(color: MyColors.darkcontrastcolor),
      ),
      onSubmitted: (text) {
        callbackSetValue(_key, text);
      },
    );

    return _textField;
  }

  void _onChangeName(Key key, String value) {
    setState(() {
      _profile.name = value;
    });
  }

  void _onChangeBreed(Key key, String value) {
    setState(() {
      _profile.breed = value;
    });
  }

  void _onChangeRemarks(Key key, String value) {
    setState(() {
      _profile.remarks = value;
    });
  }

  Widget createDateField(
      Key _key, String title, void callbackSetValue(Key k, DateTime v)) {
    final format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      key: _key,
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      autofocus: true,
      style: TextStyle(
        color: MyColors.lightcontrastcolor,
        fontSize: 20,
      ),
      decoration: new InputDecoration(
        labelText: title,
        labelStyle: new TextStyle(color: MyColors.darkcontrastcolor),
      ),
      onChanged: (text) {
        callbackSetValue(_key, text);
      },
    );
  }
}
