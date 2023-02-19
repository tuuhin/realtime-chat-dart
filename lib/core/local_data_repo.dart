///[LocalDataRepo] contains the the functions that can be overriden via a
///storage mechanisms like database or shared preferences
abstract class LocalDataRepo {
  Future<String?> getUsername();
  Future<void> setUsername(String name);
}
