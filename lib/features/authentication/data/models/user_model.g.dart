// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => $checkedCreate(
  'UserModel',
  json,
  ($checkedConvert) {
    final val = UserModel(
      userId: $checkedConvert('user_id', (v) => v as String),
      username: $checkedConvert('username', (v) => v as String),
      fullName: $checkedConvert('fullname', (v) => v as String),
      buckleNo: $checkedConvert('buckle_no', (v) => v as String?),
      mobile: $checkedConvert('mobile', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String?),
      designation: $checkedConvert('designation', (v) => v as String?),
      policeStation: $checkedConvert('police_station', (v) => v as String?),
      district: $checkedConvert('district', (v) => v as String?),
      state: $checkedConvert('state', (v) => v as String?),
      profileImage: $checkedConvert('profile_image', (v) => v as String?),
      isVerified: $checkedConvert('is_verified', (v) => v as bool? ?? false),
      subscriptionStatus: $checkedConvert(
        'subscription_status',
        (v) => v as String?,
      ),
      subscriptionExpiry: $checkedConvert(
        'subscription_expiry',
        (v) => v as String?,
      ),
      createdAt: $checkedConvert('created_at', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'userId': 'user_id',
    'fullName': 'fullname',
    'buckleNo': 'buckle_no',
    'policeStation': 'police_station',
    'profileImage': 'profile_image',
    'isVerified': 'is_verified',
    'subscriptionStatus': 'subscription_status',
    'subscriptionExpiry': 'subscription_expiry',
    'createdAt': 'created_at',
  },
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'username': instance.username,
  'fullname': instance.fullName,
  if (instance.buckleNo case final value?) 'buckle_no': value,
  'mobile': instance.mobile,
  if (instance.email case final value?) 'email': value,
  if (instance.designation case final value?) 'designation': value,
  if (instance.policeStation case final value?) 'police_station': value,
  if (instance.district case final value?) 'district': value,
  if (instance.state case final value?) 'state': value,
  if (instance.profileImage case final value?) 'profile_image': value,
  'is_verified': instance.isVerified,
  if (instance.subscriptionStatus case final value?)
    'subscription_status': value,
  if (instance.subscriptionExpiry case final value?)
    'subscription_expiry': value,
  if (instance.createdAt case final value?) 'created_at': value,
};
