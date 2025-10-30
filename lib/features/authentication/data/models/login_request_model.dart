import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

/// Login Request Model
@JsonSerializable()
class LoginRequestModel {
  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'password')
  final String password;

  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  /// From JSON
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
