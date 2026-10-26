import 'package:dartz/dartz.dart';
import 'package:mediconnect/core/errors/failures.dart';
import 'package:mediconnect/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
