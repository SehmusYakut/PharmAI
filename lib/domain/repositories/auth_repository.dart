import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserProfile>> signInWithGoogle();
  Future<Either<Failure, UserProfile>> signInAnonymously();
  Future<Either<Failure, Unit>> signOut();
  Stream<String?> get authStateChanges;
}
