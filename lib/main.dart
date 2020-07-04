///
/// The foundation of any Flutter app, the main.dart file, should hold very little code and only serve as an overview to an app.
///
/// The widget being run by runApp should be a StatelessWidget, and the itself should be no more complicated than a simple MaterialApp wrapped in the necessary BLoC providers.
/// The MaterialApp itself should have no heavy code in it, instead pulling the Theme and the widget screens from other files.
///
/// @see https://medium.com/flutter-community/flutter-code-organization-de3a4c219149
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flftrainingapp/screens.dart';
import 'package:flftrainingapp/models.dart';
import 'package:flftrainingapp/services.dart';

//import Url of training_page for routing
//import 'package:haller-flf-training-app/training_page.dart';

// Main entry point
void main() => runApp(MyApp());

// The application
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialApp _app = MaterialApp(
      title: 'Equiapp',
      theme: MyColors.mybasicTheme(

          // ThemeData.light(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          ),
      home: MyHomePage(title: 'Equikinetic'),
      //initialisation of routs
      //also see https://flutter.dev/docs/cookbook/navigation/named-routes
      // routes: {
      //   '/training_page': (context) => Training(),
    );

    final MultiProvider _commonStateProvider = new MultiProvider(
        // list of observable providers
        providers: [
          ChangeNotifierProvider<CurrentState>(
              create: (_) => new CurrentState())
        ], child: _app);

    return _commonStateProvider;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// Enumeration of available tabs for the application's bottom bar.
enum _EBottomAppTab { START, DIARY, PROFILES, SETTINGS }

class _MyHomePageState extends State<MyHomePage> {
  // the currently selected application tab
  _EBottomAppTab _selectedAppTab = _EBottomAppTab.START;

  /// Create the BottomNavigationBar that is shown in all screens.
  BottomNavigationBar _createBottomNavigationBar() {
    final BottomNavigationBar bar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        // Index 0: _EBottomAppTab.START
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Start')),

        // Index 1: _EBottomAppTab.DIARY
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day), title: Text('Diary')),

        // Index 2: _EBottomAppTab.PROFILES
        BottomNavigationBarItem(
            icon: Icon(Icons.contacts), title: Text('Horses')),

        // Index 3: _EBottomAppTab.SETTINGS
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text('Settings'))
      ],
      currentIndex: _selectedAppTab.index,
      onTap: _onAppTabSelected,
      // TODO need theme support, how?
      backgroundColor: MyColors.darkcontrastcolor,
      selectedItemColor: MyColors.buttoncolor,
      unselectedItemColor: MyColors.darkcontrastcolor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
    return bar;
  }

  /// Event handler if an item in the BottomNavigationBar gets selected.
  void _onAppTabSelected(int index) {
    setState(() {
      _selectedAppTab = _EBottomAppTab.values.elementAt(index);
    });
  }

  /// Return the screen according to the selected tab
  Widget _createSelectedScreen(_EBottomAppTab selectedTab) {
    switch (selectedTab) {
      case _EBottomAppTab.START:
        return HomeScreen();

      case _EBottomAppTab.PROFILES:
        return ProfilesListScreen();

      case _EBottomAppTab.SETTINGS:
        return SettingsScreen();

      case _EBottomAppTab.DIARY:

      default:
        return Text("Not yet implemented");
    }
  }

  /// Build the widget tree for the app.
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    var bottomNavigationBar = _createBottomNavigationBar();
    var currentScreen = _createSelectedScreen(_selectedAppTab);

    return Scaffold(
      backgroundColor: MyColors.backgroundcolor,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(color: MyColors.lightcontrastcolor),
        ),
        backgroundColor: MyColors.darkcontrastcolor,
      ),
      //ListView Problem solved!!!
      body: ListView(
        children: <Widget>[
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                currentScreen,
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
