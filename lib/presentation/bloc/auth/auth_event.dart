part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class _AuthUserChanged extends AuthEvent {
  const _AuthUserChanged(this.uid);
  final String? uid;
}
