import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/repositories/app_preferences_repository.dart';
import 'package:pharmai/presentation/bloc/onboarding/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._preferences) : super(const OnboardingState.initial());

  final AppPreferencesRepository _preferences;

  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));
    final shouldShow = await _preferences.isFirstRun();
    emit(state.copyWith(isLoading: false, shouldShow: shouldShow));
  }

  Future<void> completeOnboarding() async {
    await _preferences.setFirstRun(false);
    emit(state.copyWith(shouldShow: false));
  }
}
