import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.isLoading, required this.shouldShow});

  const OnboardingState.initial() : this(isLoading: true, shouldShow: false);

  final bool isLoading;
  final bool shouldShow;

  OnboardingState copyWith({bool? isLoading, bool? shouldShow}) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      shouldShow: shouldShow ?? this.shouldShow,
    );
  }

  @override
  List<Object?> get props => [isLoading, shouldShow];
}
