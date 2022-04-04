import 'package:shared_preferences/shared_preferences.dart';

class NyaPrefs {
  static late final SharedPreferences _instance;

  static SharedPreferences get instance {
    return _instance;
  }

  static Future init([Map<String, String>? defaults]) async {
    _instance = await SharedPreferences.getInstance();

    if (defaults != null) {
      defaults
        .entries
        .forEach((element) {
          _instance.setString(element.key, element.value);
        });
    }
  }
}