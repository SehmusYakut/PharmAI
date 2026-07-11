import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

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
}
