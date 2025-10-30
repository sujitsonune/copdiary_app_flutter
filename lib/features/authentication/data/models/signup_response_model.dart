import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'signup_response_model.g.dart';

/// Signup Response Model
@JsonSerializable(explicitToJson: true)
class SignupResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'datas')
  final SignupDataModel? data;

  const SignupResponseModel({
    required this.success,
    required this.status,
    this.message,
    this.data,
  });

  /// From JSON
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SignupResponseModelToJson(this);
}

/// Signup Data Model
@JsonSerializable(explicitToJson: true)
class SignupDataModel {
  @JsonKey(name: 'user')
  final UserModel user;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'auth_token')
  final String? authToken;

  const SignupDataModel({
    required this.user,
    this.token,
    this.authToken,
  });

  /// Get the actual token (prefer auth_token, fallback to token)
  String? get actualToken => authToken ?? token;

  /// From JSON
  factory SignupDataModel.fromJson(Map<String, dynamic> json) =>
      _$SignupDataModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SignupDataModelToJson(this);
}
