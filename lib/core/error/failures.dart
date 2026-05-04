import 'package:equatable/equatable.dart';

/// Base failure class for the Domain layer.
/// Used as the Left side of `Either<Failure, T>` (fpdart).
abstract class Failure extends Equatable {
  const Failure([this.message = '']);
  final String message;

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local database error.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network request failed.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Input validation failed.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Requested resource not found.']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred.']);
}
