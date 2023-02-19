import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_repo.dart';
import 'local_storage.dart';

final _prefernses = Provider<Future<SharedPreferences>>(
    (ref) => SharedPreferences.getInstance());

final localDataProvider =
    Provider<LocalDataRepo>((ref) => LocalStorage(ref.read(_prefernses)));
