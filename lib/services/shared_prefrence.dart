import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  AppPref._();

  static SharedPreferences? _pref;

  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  static Future<bool> save(AppPrefKey key, dynamic value) async {
    // log('PreferenceKey $key, Value: $value, Type: ${value.runtimeType}');

    if (value == null) {
      return false;
    }

    switch (value.runtimeType) {
      case String:
        return _pref!.setString(key.name, value as String);
      case int:
        return _pref!.setInt(key.name, value as int);
      case bool:
        return _pref!.setBool(key.name, value as bool);
      case double:
        return _pref!.setDouble(key.name, value as double);
      case const (List<String>):
        return _pref!.setStringList(key.name, value as List<String>);
    }

    //log('PreferenceKey return false');
    return false;
  }

  static dynamic get(AppPrefKey key, dynamic defaultValue) {
    final value = _pref!.get(key.name) ?? defaultValue;
    //log('PreferenceKey $key Value: $value');
    return value;
  }

  static Future<bool> remove(AppPrefKey key) async {
    return _pref!.remove(key.name);
  }

  static Future<bool> clear() async {
    return _pref!.clear();
  }
}

enum AppPrefKey {
  userModal('userModal'),
  loggedIn('loggedIn');

  const AppPrefKey(this.name);

  final String name;
}

class AppPrefHelper {
  static Future<bool> setUserModal({required String userModal}) async {
    return AppPref.save(AppPrefKey.userModal, userModal);
  }

  static String getUserModal() {
    final userModal = AppPref.get(AppPrefKey.userModal, '{}') as String;
    // log('uid: $uid');
    return userModal;
  }

  static Future<bool> setLoggedIn({required bool loggedIn}) async {
    return AppPref.save(AppPrefKey.loggedIn, loggedIn);
  }

  static bool getLoggedIn() {
    final loggedIn = AppPref.get(AppPrefKey.loggedIn, false) as bool;
    // log('displayName: $displayName');
    return loggedIn;
  }

  static Future<void> signOut() async {
    await AppPref.remove(AppPrefKey.loggedIn);
    await AppPref.remove(AppPrefKey.userModal);
  }
}
