import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_repo.dart';

class LocalStorage implements LocalDataRepo {
  final Future<SharedPreferences> _pref;

  LocalStorage(this._pref);

  @override
  Future<String?> getUsername() async => (await _pref).getString("username");

  @override
  Future<void> setUsername(String name) async =>
      (await _pref).setString("username", name);
}
