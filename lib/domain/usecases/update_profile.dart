import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';

class UpdateProfile {
  const UpdateProfile(this._repo);
  final ProfileRepository _repo;

  Future<Either<Failure, Unit>> call(UserProfile profile) =>
      _repo.updateProfile(profile);
}
