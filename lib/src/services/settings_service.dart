///
/// Service managing user's preferences and settings:
/// - load settings into memory
/// - store changed settings
///
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flftrainingapp/models.dart';

class SettingsService {
  static const FILE_SETTINGS = "settings.json";

  /// in-memory copy of the settings
  Settings _settings = new Settings();

  ///
  /// Return the current settings
  ///
  Settings get settings => _settings;

  // TODO need hook to call or automatically save the settings

  ///
  /// Return the local directory where this application stores its data
  /// See
  /// https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  ///
  Future<Directory> getApplicationDataPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  ///
  /// Load the settings from persistence
  ///
  Future<Settings> _loadSettings() async {
    final Directory dirApp = await getApplicationDataPath();
    final String path = dirApp.path;
    final File fileSettings = new File('$path/$FILE_SETTINGS');
    Settings settings;

    try {
      // 1 - try to read the file
      String data = await fileSettings.readAsString();

      // 2 - parse JSON into a Settings object
      Map<String, dynamic> mapData = jsonDecode(data);
      settings = Settings.fromJson(mapData);
    } catch (e) {
      // 3 - if the file does not exist, or cannot be read, return defaults
      settings = new Settings();
    }

    return settings;
  }

  ///
  /// Save the settings to persistence
  ///
  Future<File> _saveSettings() async {
    final Directory dirApp = await getApplicationDataPath();
    final String path = dirApp.path;
    final File fileSettings = new File('$path/$FILE_SETTINGS');

    try {
      // 1 - serialize the Settings to a JSON structure
      Map<String, dynamic> jsonData = settings.toJson();
      String jsonString = jsonEncode(jsonData);

      // 2 - write the file
      return fileSettings.writeAsString(jsonString);
    } catch (e) {
      print("Failed to save settings" + e.toString());
    }

    return fileSettings;
  }
}
