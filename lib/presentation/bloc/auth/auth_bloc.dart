import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/auth/auth_state_notifier.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';
import 'package:pharmai/domain/usecases/sign_in_with_google.dart';
import 'package:pharmai/domain/usecases/sign_in_with_apple.dart';
import 'package:pharmai/domain/usecases/sign_in_anonymously.dart';
import 'package:pharmai/domain/usecases/sign_out.dart';
import 'package:pharmai/domain/usecases/delete_account.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepo,
    required ProfileRepository profileRepo,
    required SignInWithGoogle signInWithGoogle,
    required SignInWithApple signInWithApple,
    required SignInAnonymously signInAnonymously,
    required SignOut signOut,
    required DeleteAccount deleteAccount,
    required AuthStateNotifier authNotifier,
  })  : _authRepo = authRepo,
        _profileRepo = profileRepo,
        _signInWithGoogle = signInWithGoogle,
        _signInWithApple = signInWithApple,
        _signInAnonymously = signInAnonymously,
        _signOut = signOut,
        _deleteAccount = deleteAccount,
        _authNotifier = authNotifier,
        super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
    on<AuthAppleSignInRequested>(_onAppleSignIn);
    on<AuthAnonymousSignInRequested>(_onAnonymousSignIn);
    on<AuthSignOutRequested>(_onSignOut);
    on<AuthDeleteAccountRequested>(_onDeleteAccount);
    on<_AuthUserChanged>(_onUserChanged);
  }

  final AuthRepository _authRepo;
  final ProfileRepository _profileRepo;
  final SignInWithGoogle _signInWithGoogle;
  final SignInWithApple _signInWithApple;
  final SignInAnonymously _signInAnonymously;
  final SignOut _signOut;
  final DeleteAccount _deleteAccount;
  final AuthStateNotifier _authNotifier;
  StreamSubscription<String?>? _authSub;

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) {
    _authSub?.cancel();
    _authSub = _authRepo.authStateChanges
        .listen((uid) => add(_AuthUserChanged(uid)));
  }

  Future<void> _onUserChanged(
    _AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.uid == null) {
      _authNotifier.update(false);
      emit(const AuthUnauthenticated());
      return;
    }
    emit(const AuthLoading());
    final result = await _profileRepo.getProfile(event.uid!);
    result.fold(
      (f) {
        _authNotifier.update(false);
        emit(AuthError(f.message));
      },
      (profile) {
        if (profile != null) {
          _authNotifier.update(true);
          emit(AuthAuthenticated(profile));
        } else {
          _authNotifier.update(false);
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onGoogleSignIn(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signInWithGoogle();
    result.fold(
      (f) => emit(AuthError(f.message)),
      (profile) {
        _authNotifier.update(true);
        emit(AuthAuthenticated(profile));
      },
    );
  }

  Future<void> _onAppleSignIn(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signInWithApple();
    result.fold(
      (f) => emit(AuthError(f.message)),
      (profile) {
        _authNotifier.update(true);
        emit(AuthAuthenticated(profile));
      },
    );
  }

  Future<void> _onAnonymousSignIn(
    AuthAnonymousSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signInAnonymously();
    result.fold(
      (f) => emit(AuthError(f.message)),
      (profile) {
        _authNotifier.update(true);
        emit(AuthAuthenticated(profile));
      },
    );
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOut();
    _authNotifier.update(false);
    emit(const AuthUnauthenticated());
  }

  Future<void> _onDeleteAccount(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _deleteAccount();
    result.fold(
      (f) => emit(AuthError(f.message)),
      (_) {
        _authNotifier.update(false);
        emit(const AuthUnauthenticated());
      },
    );
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
