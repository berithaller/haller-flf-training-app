///
/// Configuration Data Model: user's preferences and settings
///

class Settings {
  /// Text-To-Speech language
  /// This selects both, the actual TTS language
  /// as well as the literals used for the audible announcements
  String audioLanguage;

  /// Text-To-Speech voice
  String audioVoice;

  /// Color Theme
  String themeName;

  ///
  /// Default constructor
  ///
  Settings()
      : audioLanguage = "en-US",
        audioVoice = null,
        themeName = "default";

  /// @returns hashcode describing the content of the object
  @override
  int get hashCode => audioLanguage?.hashCode ^ themeName?.hashCode;

  /// @return <code>true</code> if <i>other</i> is identical or has identical content of the current object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Settings &&
          audioLanguage == other.audioLanguage &&
          audioVoice == other.audioVoice &&
          themeName == other.themeName);

  ///
  /// Converts the supplied [Map] to an instance of [Settings].
  ///
  static Settings fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap == null) {
      throw ArgumentError('The parameter \'jsonMap\' must not be null.');
    }

    final Settings settings = new Settings();
    settings.audioLanguage = jsonMap['audioLanguage'];
    settings.audioVoice = jsonMap['audioVoice'];
    settings.themeName = jsonMap['themeName'];

    return settings;
  }

  ///
  /// Converts the [Settings] instance into a [Map] instance that can be serialized to JSON.
  ///
  Map<String, dynamic> toJson() => {
        'audioLanguage': audioLanguage,
        'audioVoice': audioVoice,
        'themeName': themeName
      };
}
