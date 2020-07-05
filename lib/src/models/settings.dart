import 'package:flutter/foundation.dart';

///
/// Configuration Data Model: user's preferences and settings
///

class Settings extends ChangeNotifier {
  /// Text-To-Speech language
  /// This selects both, the actual TTS language
  /// as well as the literals used for the audible announcements
  String _audioLanguage;

  /// Text-To-Speech voice
  String _audioVoice;

  /// Text-To-Speech pitch
  double _audioPitch;

  /// Text-To-Speech volume
  double _audioVolume;

  /// Text-To-Speech speech rate
  double _audioSpeechRate;

  /// Color Theme
  String _themeName;

  ///
  /// Default constructor
  ///
  Settings()
      : _audioLanguage = "de-DE",
        _audioVoice = null,
        _audioVolume = 1.0,
        _audioPitch = 1.0,
        _audioSpeechRate = 1.0,
        _themeName = "default";

  ///
  /// Getter/Setter for audioLanguage
  ///
  String get audioLanguage => _audioLanguage;
  set audioLanguage(String newAudioLanguage) {
    if (newAudioLanguage != _audioLanguage) {
      _audioLanguage = newAudioLanguage;
      notifyListeners();
    }
  }

  ///
  /// Getter/Setter for audioVoice
  ///
  String get audioVoice => _audioVoice;
  set audioVoice(String newAudioVoice) {
    if (newAudioVoice != _audioVoice) {
      _audioVoice = newAudioVoice;
      notifyListeners();
    }
  }

  ///
  /// Getter/Setter for audioPitch
  ///
  double get audioPitch => _audioPitch;
  set audioPitch(double newAudioPitch) {
    if (newAudioPitch != _audioPitch) {
      _audioPitch = newAudioPitch;
      notifyListeners();
    }
  }

  ///
  /// Getter/Setter for audioVolume
  ///
  double get audioVolume => _audioVolume;
  set audioVolume(double newAudioVolume) {
    if (newAudioVolume != _audioVolume) {
      _audioVolume = newAudioVolume;
      notifyListeners();
    }
  }

  ///
  /// Getter/Setter for audioSpeechRate
  ///
  double get audioSpeechRate => _audioSpeechRate;
  set audioSpeechRate(double newAudioSpeechRate) {
    if (newAudioSpeechRate != _audioSpeechRate) {
      _audioSpeechRate = newAudioSpeechRate;
      notifyListeners();
    }
  }

  ///
  /// Getter/Setter for audioVolume
  ///
  String get themeName => _themeName;
  set themeName(String newThemeName) {
    if (newThemeName != _themeName) {
      _themeName = newThemeName;
      notifyListeners();
    }
  }

  /// @returns hashcode describing the content of the object
  @override
  int get hashCode =>
      _audioLanguage?.hashCode ^
      _audioVoice?.hashCode ^
      _audioPitch?.hashCode ^
      _audioVolume?.hashCode ^
      _audioSpeechRate?.hashCode ^
      _themeName?.hashCode;

  /// @return <code>true</code> if <i>other</i> is identical or has identical content of the current object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Settings &&
          _audioLanguage == other._audioLanguage &&
          _audioVoice == other._audioVoice &&
          _audioPitch == other._audioPitch &&
          _audioVolume == other._audioVolume &&
          _audioSpeechRate == other._audioSpeechRate &&
          _themeName == other._themeName);

  ///
  /// Converts the supplied [Map] to an instance of [Settings].
  ///
  static Settings fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) {
      throw ArgumentError('The parameter \'jsonMap\' must not be null.');
    }

    final Settings settings = new Settings();
    settings._audioLanguage = jsonMap['audioLanguage'];
    settings._audioVoice = jsonMap['audioVoice'];
    settings._audioPitch = jsonMap['audioPitch'];
    settings._audioVolume = jsonMap['audioVolume'];
    settings._audioSpeechRate = jsonMap['audioSpeechRate'];
    settings._themeName = jsonMap['themeName'];

    return settings;
  }

  ///
  /// Converts the [Settings] instance into a [Map] instance that can be serialized to JSON.
  ///
  Map<String, dynamic> toJson() => {
        'audioLanguage': _audioLanguage,
        'audioVoice': _audioVoice,
        'audioPitch': _audioPitch,
        'audioVolume': _audioVolume,
        'audioSpeechRate': _audioSpeechRate,
        'themeName': _themeName
      };
}
