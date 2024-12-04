import 'package:shared_preferences/shared_preferences.dart';
import 'package:yash_practical/core/constants/shared_preferences_constants.dart';

class SharedPreferencesStorage {
  static Future<void> setBool({
    required String keyPrefix,
    required bool value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(keyPrefix, value);
  }

  static Future<bool> getBool({
    required String keyPrefix,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(keyPrefix) ?? false;
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConstants.isSyncData);
  }
}
