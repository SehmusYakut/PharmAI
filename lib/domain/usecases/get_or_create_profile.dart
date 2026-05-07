import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class GetOrCreateProfile {
  const GetOrCreateProfile(this._repo);
  final ProfileRepository _repo;

  Future<Either<Failure, UserProfile>> call({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) =>
      _repo.getOrCreate(
        uid: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
      );
}
