
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NyaSettingsModel extends ChangeNotifier {
  late final SharedPreferences _prefs;
  final Map<String, dynamic> _default = {};
  final Map<String, String> _translate = {};

  Future init() async {
    _prefs = await SharedPreferences.getInstance();

    var prefsKeys = _prefs.getKeys();

    for (var key in prefsKeys) {
      _default[key] = _prefs.get(key);
    }

    for (var key in _default.keys.where((k) => prefsKeys.contains(k))) {
      set(key, _default[key]);
    }
  }

  Map<String, dynamic> getAll() {
    Map<String, dynamic> map = {};

    for (var key in _prefs.getKeys()) {
      map[key] = _prefs.get(key);
    }

    return map;
  }

  T get<T>(String key) {
    return _prefs.get(key) as T;
  }

  void set(String key, dynamic value) {

    switch (value.runtimeType) {
      case bool:
        _prefs.setBool(key, value);
        break;
      case String:
        _prefs.setString(key, value);
        break;
    }

    notifyListeners();
  }

  String translate(String key) {
    return _translate[key] ?? key;
  }
}