import 'package:pharmai/data/datasources/local/app_preferences_local_data_source.dart';
import 'package:pharmai/domain/repositories/app_preferences_repository.dart';

class AppPreferencesRepositoryImpl implements AppPreferencesRepository {
  const AppPreferencesRepositoryImpl(this._local);

  final AppPreferencesLocalDataSource _local;

  @override
  Future<bool> isFirstRun() => _local.isFirstRun();

  @override
  Future<void> setFirstRun(bool value) => _local.setFirstRun(value);
}
