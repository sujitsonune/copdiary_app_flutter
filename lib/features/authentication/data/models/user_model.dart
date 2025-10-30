import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

/// User Model for data layer
/// Maps to API response and extends domain entity
@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'username')
  final String username;

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

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;

  @JsonKey(name: 'subscription_expiry')
  final String? subscriptionExpiry;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const UserModel({
    required this.userId,
    required this.username,
    required this.fullName,
    this.buckleNo,
    required this.mobile,
    this.email,
    this.designation,
    this.policeStation,
    this.district,
    this.state,
    this.profileImage,
    this.isVerified = false,
    this.subscriptionStatus,
    this.subscriptionExpiry,
    this.createdAt,
  }) : super(
          userId: userId,
          username: username,
          fullName: fullName,
          buckleNo: buckleNo,
          mobile: mobile,
          email: email,
          designation: designation,
          policeStation: policeStation,
          district: district,
          state: state,
          profileImage: profileImage,
          isVerified: isVerified,
          subscriptionStatus: subscriptionStatus,
          subscriptionExpiry: subscriptionExpiry,
        );

  /// From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Copy with
  UserModel copyWith({
    String? userId,
    String? username,
    String? fullName,
    String? buckleNo,
    String? mobile,
    String? email,
    String? designation,
    String? policeStation,
    String? district,
    String? state,
    String? profileImage,
    bool? isVerified,
    String? subscriptionStatus,
    String? subscriptionExpiry,
    String? createdAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      buckleNo: buckleNo ?? this.buckleNo,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      designation: designation ?? this.designation,
      policeStation: policeStation ?? this.policeStation,
      district: district ?? this.district,
      state: state ?? this.state,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
