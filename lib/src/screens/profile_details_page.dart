import 'package:flftrainingapp/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override

  final Key keyName = Key("KEY_Name");

  Widget build(BuildContext context) {
    return Column(
      //createTextField(keyName, "Name",callbackSetText),

    );
  }

  Widget createTextField(
      Key _key, String title, void callbackSetValue(Key k, String s)) {
    return TextField(
      key: _key,
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
