import 'package:dio/dio.dart';
import 'package:mediconnect/core/api/api_service.dart';
import 'package:mediconnect/core/errors/exceptions.dart';
import 'package:mediconnect/features/auth/data/models/login_request_model.dart';
import 'package:mediconnect/features/auth/data/models/login_response_model.dart';
import 'package:mediconnect/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserEntity> login(LoginRequestModel request) async {
    try {
      final LoginResponseModel response = await apiService.login(request);
      if (response.user != null) {
        return response.user!.toEntity();
      } else {
        return UserEntity(
          id: '1',
          name: 'User',
          email: request.email,
          token: response.token,
        );
      }
    } on DioException catch (dioException) {
      String message = 'Server communication error';
      final data = dioException.response?.data;
      if (data is Map<String, dynamic> && data['message'] != null) {
        message = data['message'].toString();
      } else if (dioException.message != null && dioException.message!.isNotEmpty) {
        message = dioException.message!;
      }
      throw ServerException(
        message: message,
        statusCode: dioException.response?.statusCode,
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
