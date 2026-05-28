import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class ThemeCubit extends Cubit<String> {
  ThemeCubit(this._profileRepo) : super('light');

  final ProfileRepository _profileRepo;
  UserProfile? _profile;

  void loadFromProfile(UserProfile profile) {
    _profile = profile;
    emit(profile.themeMode);
  }

  Future<void> setTheme(String themeMode) async {
    emit(themeMode);
    if (_profile == null) return;
    final updated = _profile!.copyWith(themeMode: themeMode);
    _profile = updated;
    await _profileRepo.updateProfile(updated);
  }

  Future<void> toggle() async {
    final next = state == 'light' ? 'dark' : (state == 'dark' ? 'midnight' : 'light');
    await setTheme(next);
  }

  void setSystem() => emit('light'); // Simplification for now
}
