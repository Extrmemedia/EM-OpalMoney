import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  //set data into shared preferences
  Future<void> setPreferenceString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

//get value from shared preferences
  Future<String> getPreferenceString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;

    auth_token = (pref.getString(key) ?? null);

    return auth_token;
  }

  //set data into shared preferences
  Future<void> setBooleanPreference(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  //get value from shared preferences
  Future<bool> getPreferenceBoolValue(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLoggedin;
    isLoggedin = pref.getBool(key) ?? false;
    return isLoggedin;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.clear();
  }
}
