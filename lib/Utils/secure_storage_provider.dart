import 'package:shared_preferences/shared_preferences.dart';

const loginToken = "jwtToken";

class SecureStorageProvider {
  readValue(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    return value;
  }

  writeValue(key, value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value is String) await prefs.setString(key, value);
      if (value is double) await prefs.setDouble(key, value);
      if (value is bool) await prefs.setBool(key, value);
    } catch (e) {}
  }

  clearAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
saveToSecuredStorage(String key, dynamic value) {
  SecureStorageProvider secureStorageProvider = SecureStorageProvider();
  secureStorageProvider.writeValue(key, value);
}
