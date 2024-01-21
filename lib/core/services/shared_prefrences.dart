import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";
const String PREFS_KEY_USER_LOGGED_IN = "PREFS_KEY_USER_LOGGED_IN";

class AppPrefernces {
  final SharedPreferences _sharedPreferences;

  AppPrefernces(this._sharedPreferences);

  // User ID
  Future<void> setUserId(String uid) async {
    _sharedPreferences.setString(PREFS_KEY_USER_ID, uid);
  }

  Future<String> getUserId() async {
    return _sharedPreferences.getString(PREFS_KEY_USER_ID) ?? '';
  }

  Future<void> removeUserId() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_ID);
  }

  // User logged in

  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN) ?? false;
  }

  Future<void> removeUserLoggedIn() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_LOGGED_IN);
  }
}
