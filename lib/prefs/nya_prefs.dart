import 'package:shared_preferences/shared_preferences.dart';

class NyaPrefs {
  static late final SharedPreferences _preferences;
  static late final Map<String, String>? defaults;

  static Future init([Map<String, String>? defaults]) async {
    _preferences = await SharedPreferences.getInstance();
    NyaPrefs.defaults = defaults;
    reset();
  }

  static SharedPreferences getInstance() {
    return _preferences;
  }

  static void reset() {
    if (defaults != null) {
      defaults!
        .entries
        .forEach((element) {
          _preferences.setString(element.key, element.value);
        });
    }
  }

}