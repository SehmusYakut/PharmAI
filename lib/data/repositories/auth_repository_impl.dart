import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._profileRepo);

  final FirebaseAuth _auth;
  final ProfileRepository _profileRepo;

  @override
  Stream<String?> get authStateChanges =>
      _auth.authStateChanges().map((u) => u?.uid);

  @override
  Future<Either<Failure, UserProfile>> signInWithGoogle() async {
    try {
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
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
