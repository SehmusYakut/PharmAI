import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._profileRepo) {
    _auth.authStateChanges().map((u) => u?.uid).listen((uid) {
      if (_mockUid == null) {
        _controller.add(uid);
      }
    });
  }

  final FirebaseAuth _auth;
  final ProfileRepository _profileRepo;

  final _controller = StreamController<String?>.broadcast();
  String? _mockUid;

  @override
  Stream<String?> get authStateChanges => _controller.stream;

  /// Generates a cryptographically secure random nonce for Apple Sign-In.
  String _generateNonce([int length = 32]) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Returns the SHA-256 hash of [input] as a hex string.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<Either<Failure, UserProfile>> signInWithGoogle() async {
    try {
      _mockUid = null;
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        return const Left(UnexpectedFailure('No ID token received'));
      }
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final result = await _auth.signInWithCredential(credential);
      final user = result.user!;
      return _profileRepo.getOrCreate(
        uid: user.uid,
        email: user.email ?? account.email,
        displayName: account.displayName ?? user.displayName,
        photoUrl: account.photoUrl ?? user.photoURL,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return const Left(ValidationFailure('Sign-in cancelled'));
      }
      return Left(UnexpectedFailure(e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> signInWithApple() async {
    try {
      _mockUid = null;
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final result = await _auth.signInWithCredential(oauthCredential);
      final user = result.user!;

      // Apple may only provide name on the first sign-in
      final displayName = [
        appleCredential.givenName ?? '',
        appleCredential.familyName ?? '',
      ].where((s) => s.isNotEmpty).join(' ');

      return _profileRepo.getOrCreate(
        uid: user.uid,
        email: appleCredential.email ?? user.email ?? '',
        displayName:
            displayName.isNotEmpty ? displayName : user.displayName,
        photoUrl: user.photoURL,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return const Left(ValidationFailure('Sign-in cancelled'));
      }
      return Left(UnexpectedFailure(e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      final user = result.user!;
      _mockUid = null;
      return _profileRepo.getOrCreate(
        uid: user.uid,
        email: user.email ?? 'guest@pharmai.example.com',
        displayName: 'Guest User',
        photoUrl: null,
      );
    } catch (e) {
      // Fallback: local mock profile in case anonymous authentication is disabled on Firebase Console
      _mockUid = 'demo_reviewer_uid';
      _controller.add(_mockUid);
      return _profileRepo.getOrCreate(
        uid: _mockUid!,
        email: 'guest@pharmai.example.com',
        displayName: 'Guest User',
        photoUrl: null,
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      if (_mockUid != null) {
        _mockUid = null;
        _controller.add(null);
      } else {
        await GoogleSignIn.instance.signOut();
        await _auth.signOut();
      }
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final uid = user.uid;
        // Cascade delete database profile & related data first (while authenticated)
        final profileDeleteResult = await _profileRepo.deleteProfile(uid);
        if (profileDeleteResult.isLeft()) {
          return const Left(UnexpectedFailure('Failed to delete local database data.'));
        }
        // Delete Firebase Auth user
        await user.delete();
      } else if (_mockUid != null) {
        final uid = _mockUid!;
        _mockUid = null;
        await _profileRepo.deleteProfile(uid);
        _controller.add(null);
      }
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return const Left(ValidationFailure('Please sign in again to delete your account.'));
      }
      return Left(UnexpectedFailure(e.message ?? e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}

