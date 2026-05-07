import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._profileRepo) : super(ThemeMode.system);

  final ProfileRepository _profileRepo;
  UserProfile? _profile;

  void loadFromProfile(UserProfile profile) {
    _profile = profile;
    emit(profile.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggle() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newMode);
    await _persist(newMode == ThemeMode.dark);
  }

  void setSystem() => emit(ThemeMode.system);

  Future<void> _persist(bool isDark) async {
    if (_profile == null) return;
    final updated = _profile!.copyWith(isDarkMode: isDark);
    _profile = updated;
    await _profileRepo.updateProfile(updated);
  }
}
