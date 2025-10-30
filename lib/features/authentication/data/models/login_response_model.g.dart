// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginResponseModel', json, ($checkedConvert) {
      final val = LoginResponseModel(
        success: $checkedConvert('success', (v) => v as bool),
        status: $checkedConvert('status', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'datas',
          (v) =>
              v == null
                  ? null
                  : LoginDataModel.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'data': 'datas'});

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      if (instance.message case final value?) 'message': value,
      if (instance.data?.toJson() case final value?) 'datas': value,
    };

LoginDataModel _$LoginDataModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginDataModel', json, ($checkedConvert) {
      final val = LoginDataModel(
        user: $checkedConvert(
          'user',
          (v) => UserModel.fromJson(v as Map<String, dynamic>),
        ),
        token: $checkedConvert('token', (v) => v as String?),
        authToken: $checkedConvert('auth_token', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'authToken': 'auth_token'});

Map<String, dynamic> _$LoginDataModelToJson(LoginDataModel instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      if (instance.token case final value?) 'token': value,
      if (instance.authToken case final value?) 'auth_token': value,
    };
