import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/domain/repositories/auth_repository.dart';

class SignOut {
  const SignOut(this._authRepo);
  final AuthRepository _authRepo;

  Future<Either<Failure, Unit>> call() => _authRepo.signOut();
}
