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

class AuthAppleSignInRequested extends AuthEvent {
  const AuthAppleSignInRequested();
}

class AuthAnonymousSignInRequested extends AuthEvent {
  const AuthAnonymousSignInRequested();
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class AuthDeleteAccountRequested extends AuthEvent {
  const AuthDeleteAccountRequested();
}

class _AuthUserChanged extends AuthEvent {
  const _AuthUserChanged(this.uid);
  final String? uid;
}
