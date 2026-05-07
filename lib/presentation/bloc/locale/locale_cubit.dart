import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._profileRepo) : super(const Locale('tr'));

  final ProfileRepository _profileRepo;
  UserProfile? _profile;

  void loadFromProfile(UserProfile profile) {
    _profile = profile;
    emit(Locale(profile.languageCode));
  }

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    if (_profile == null) return;
    final updated = _profile!.copyWith(languageCode: locale.languageCode);
    _profile = updated;
    await _profileRepo.updateProfile(updated);
  }
}
