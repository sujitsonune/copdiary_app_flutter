// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponseModel _$SignupResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignupResponseModel', json, ($checkedConvert) {
      final val = SignupResponseModel(
        success: $checkedConvert('success', (v) => v as bool),
        status: $checkedConvert('status', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'datas',
          (v) =>
              v == null
                  ? null
                  : SignupDataModel.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'data': 'datas'});

Map<String, dynamic> _$SignupResponseModelToJson(
  SignupResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  if (instance.message case final value?) 'message': value,
  if (instance.data?.toJson() case final value?) 'datas': value,
};

SignupDataModel _$SignupDataModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignupDataModel', json, ($checkedConvert) {
      final val = SignupDataModel(
        user: $checkedConvert(
          'user',
          (v) => UserModel.fromJson(v as Map<String, dynamic>),
        ),
        token: $checkedConvert('token', (v) => v as String?),
        authToken: $checkedConvert('auth_token', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'authToken': 'auth_token'});

Map<String, dynamic> _$SignupDataModelToJson(SignupDataModel instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      if (instance.token case final value?) 'token': value,
      if (instance.authToken case final value?) 'auth_token': value,
    };
