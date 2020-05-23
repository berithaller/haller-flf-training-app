import 'package:flutter/widgets.dart';
import 'package:screens/home_screen.dart';
import 'package:screens/profiles_list.dart';
import 'package:screens/profiles_add.dart';
import 'package:screens/profiles_edit.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/profiles/list": (BuildContext context) => ProfilesListScreen(),
  "/profiles/add": (BuildContext context) => ProfilesAddScreen(),
  "/profiles/edit": (BuildContext context) => ProfileEditScreen()
};
