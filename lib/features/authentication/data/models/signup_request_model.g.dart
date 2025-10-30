// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequestModel _$SignupRequestModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SignupRequestModel',
      json,
      ($checkedConvert) {
        final val = SignupRequestModel(
          username: $checkedConvert('username', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          fullName: $checkedConvert('fullname', (v) => v as String),
          buckleNo: $checkedConvert('buckle_no', (v) => v as String?),
          mobile: $checkedConvert('mobile', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String?),
          designation: $checkedConvert('designation', (v) => v as String?),
          policeStation: $checkedConvert('police_station', (v) => v as String?),
          district: $checkedConvert('district', (v) => v as String?),
          state: $checkedConvert('state', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'fullName': 'fullname',
        'buckleNo': 'buckle_no',
        'policeStation': 'police_station',
      },
    );

Map<String, dynamic> _$SignupRequestModelToJson(SignupRequestModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullName,
      if (instance.buckleNo case final value?) 'buckle_no': value,
      'mobile': instance.mobile,
      if (instance.email case final value?) 'email': value,
      if (instance.designation case final value?) 'designation': value,
      if (instance.policeStation case final value?) 'police_station': value,
      if (instance.district case final value?) 'district': value,
      if (instance.state case final value?) 'state': value,
    };
