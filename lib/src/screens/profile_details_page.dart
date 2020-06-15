import 'package:flftrainingapp/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flftrainingapp/models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
  final Key keyOwner = Key("KEY_Owner");
  final Key keyBirthday = Key("KEY_Birthday");

  final _picker = ImagePicker();
  File _image;

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
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: new Column(children: <Widget>[
                createTextField(keyName, "Name", _profile.name, _onChangeName),
                createTextField(
                    keyBreed, "Rasse", _profile.breed, _onChangeBreed),
                createTextField(
                    keyOwner, "Besitzer", _profile.contactId, _onChangeOwner),
                createTextField(keyRemarks, "Sonstiges", _profile.remarks,
                    _onChangeRemarks),
                createDateField(keyBirthday, "Geburtsdatum", _profile.birthday,
                    _onChangeBirthday),
                if (createAddPicture() != null) (createAddPicture()),
                if (_image == null) Text('No image selected.') else Image.file(_image),
              ]),
            ),
          ],
        ));
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
        color: MyColors.darkcontrastcolor,
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

  void _onChangeOwner(Key key, String value) {
    setState(() {
      _profile.contactId = value;
    });
  }

  void _onChangeBirthday(Key key, DateTime value) {
    setState(() {
      _profile.birthday = value;
    });
  }


  //Problem: Daten bleiben nicht eingetragen, Formatierung, Uhrzeit sollte nicht angezeigt werden, Auswahl mühsam
  Widget createDateField(Key _key, String title, DateTime _value,
      void callbackSetValue(Key k, DateTime v)) {
    final TextEditingController _controller =
    new TextEditingController(text: _value.toString());

    _disposeList.add(_controller.dispose);

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
        color: MyColors.darkcontrastcolor,
        fontSize: 20,
      ),
      decoration: new InputDecoration(
        labelText: title,
        labelStyle: new TextStyle(
            color: MyColors.darkcontrastcolor, fontSize: 20),
      ),
      onChanged: (date) {
        callbackSetValue(_key, date);
      },
    );
  }

  Widget createAddPicture()  {
    FloatingActionButton(
        child: Icon(Icons.add_a_photo, color: MyColors.darkcontrastcolor,),
        backgroundColor: MyColors.buttoncolor,
        tooltip: 'Pick Image',
        onPressed: ()  {
          getImage();
        }
    );
  }
  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}