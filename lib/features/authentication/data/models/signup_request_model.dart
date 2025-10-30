import 'package:json_annotation/json_annotation.dart';

part 'signup_request_model.g.dart';

/// Signup Request Model
@JsonSerializable()
class SignupRequestModel {
  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'fullname')
  final String fullName;

  @JsonKey(name: 'buckle_no')
  final String? buckleNo;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'designation')
  final String? designation;

  @JsonKey(name: 'police_station')
  final String? policeStation;

  @JsonKey(name: 'district')
  final String? district;

  @JsonKey(name: 'state')
  final String? state;

  const SignupRequestModel({
    required this.username,
    required this.password,
    required this.fullName,
    this.buckleNo,
    required this.mobile,
    this.email,
    this.designation,
    this.policeStation,
    this.district,
    this.state,
  });

  /// From JSON
  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SignupRequestModelToJson(this);
}
