import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mediconnect/features/auth/data/models/login_request_model.dart';
import 'package:mediconnect/features/auth/data/models/login_response_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST('auth/login')
  Future<LoginResponseModel> login(
    @Body() LoginRequestModel request,
  );
}
