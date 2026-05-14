abstract class AppPreferencesRepository {
  Future<bool> isFirstRun();
  Future<void> setFirstRun(bool value);
}
