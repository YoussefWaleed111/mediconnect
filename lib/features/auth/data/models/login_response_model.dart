import 'package:json_annotation/json_annotation.dart';
import 'package:mediconnect/features/auth/data/models/user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool? success;
  final String? message;
  final UserModel? user;
  final String? token;

  const LoginResponseModel({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
