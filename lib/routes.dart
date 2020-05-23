import 'package:flutter/widgets.dart';
import 'screens.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/profiles/list": (BuildContext context) => ProfilesListScreen(),
// TODO   "/profiles/add": (BuildContext context) => ProfilesAddScreen(),
// TODO   "/profiles/edit": (BuildContext context) => ProfileEditScreen()
};
