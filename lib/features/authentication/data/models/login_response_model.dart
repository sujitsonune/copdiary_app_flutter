import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'login_response_model.g.dart';

/// Login Response Model
/// Matches Android API response structure
@JsonSerializable(explicitToJson: true)
class LoginResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'datas')
  final LoginDataModel? data;

  const LoginResponseModel({
    required this.success,
    required this.status,
    this.message,
    this.data,
  });

  /// From JSON
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

/// Login Data Model containing user and token
@JsonSerializable(explicitToJson: true)
class LoginDataModel {
  @JsonKey(name: 'user')
  final UserModel user;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'auth_token')
  final String? authToken;

  const LoginDataModel({
    required this.user,
    this.token,
    this.authToken,
  });

  /// Get the actual token (prefer auth_token, fallback to token)
  String? get actualToken => authToken ?? token;

  /// From JSON
  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
}
