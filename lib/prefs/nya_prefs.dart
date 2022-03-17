import 'package:shared_preferences/shared_preferences.dart';

class NyaPrefs {
  static late final SharedPreferences _instance;
  static SharedPreferences get instance {
    return _instance;
  }

  static Future init() async {
    _instance = await SharedPreferences.getInstance();
  }
}