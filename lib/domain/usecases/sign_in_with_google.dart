import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  const SignInWithGoogle(this._authRepo);
  final AuthRepository _authRepo;

  Future<Either<Failure, UserProfile>> call() => _authRepo.signInWithGoogle();
}
