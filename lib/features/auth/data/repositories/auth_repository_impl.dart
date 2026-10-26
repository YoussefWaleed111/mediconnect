import 'package:dartz/dartz.dart';
import 'package:mediconnect/core/api/dio_factory.dart';
import 'package:mediconnect/core/errors/exceptions.dart';
import 'package:mediconnect/core/errors/failures.dart';
import 'package:mediconnect/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mediconnect/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mediconnect/features/auth/data/models/login_request_model.dart';
import 'package:mediconnect/features/auth/domain/entities/user_entity.dart';
import 'package:mediconnect/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final requestModel = LoginRequestModel(
        email: email,
        password: password,
      );

      final UserEntity userEntity = await remoteDataSource.login(requestModel);

      if (userEntity.token != null) {
        await localDataSource.saveToken(userEntity.token!);
        DioFactory.setTokenIntoHeader(userEntity.token!);
      }

      return Right(userEntity);
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
      );
    } on CacheException catch (exception) {
      return Left(CacheFailure(message: exception.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clear();
      DioFactory.clearTokenFromHeader();
      return const Right(null);
    } on CacheException catch (exception) {
      return Left(CacheFailure(message: exception.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token != null) {
        return Right(UserEntity(id: '1', name: 'User', email: '', token: token));
      }
      return const Right(null);
    } on CacheException catch (exception) {
      return Left(CacheFailure(message: exception.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
