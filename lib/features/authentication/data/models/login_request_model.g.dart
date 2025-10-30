// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginRequestModel', json, ($checkedConvert) {
      final val = LoginRequestModel(
        username: $checkedConvert('username', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
