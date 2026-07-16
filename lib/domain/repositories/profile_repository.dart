import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getOrCreate({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
  });
  Future<Either<Failure, UserProfile?>> getProfile(String uid);
  Future<Either<Failure, Unit>> updateProfile(UserProfile profile);
  Future<Either<Failure, Unit>> deleteProfile(String uid);
}
