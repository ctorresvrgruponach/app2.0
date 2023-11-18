import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<String> getdatos(variable) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final nombre = prefs.getString(variable) ?? '';
    return (nombre);
  }

  static setdatos(variable, valor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(variable!, valor!);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static borrashared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  static Future<Map?> getdatosall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final prefsMap = <String, dynamic>{};
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    ////print(prefsMap);
    return (prefsMap);
  }
}

void pref(clave, valor) {
  SharedPreferencesHelper.setdatos(clave, valor);
}
