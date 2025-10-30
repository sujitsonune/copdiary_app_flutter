import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/signup_request_model.dart';
import '../models/signup_response_model.dart';

part 'auth_remote_datasource.g.dart';

/// Authentication Remote Data Source Interface
abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<SignupResponseModel> signup(SignupRequestModel request);
  Future<Map<String, dynamic>> forgotPassword(String mobile);
  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp);
  Future<Map<String, dynamic>> resetPassword(
    String mobile,
    String otp,
    String newPassword,
  );
  Future<Map<String, dynamic>> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  );
  Future<void> logout();
}

/// Authentication Remote Data Source Implementation using Retrofit
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRemoteDataSourceRetrofit {
  factory AuthRemoteDataSourceRetrofit(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSourceRetrofit;

  /// Login endpoint
  @POST('Api/login_check')
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  /// Signup endpoint
  @POST(ApiConstants.register)
  Future<SignupResponseModel> signup(@Body() SignupRequestModel request);

  /// Forgot password endpoint
  @POST(ApiConstants.forgotPassword)
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> forgotPassword(
    @Field('mobile') String mobile,
  );

  /// Verify OTP endpoint
  @POST(ApiConstants.verifyOtp)
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> verifyOtp(
    @Field('mobile') String mobile,
    @Field('otp') String otp,
  );

  /// Reset password endpoint
  @POST(ApiConstants.resetPassword)
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> resetPassword(
    @Field('mobile') String mobile,
    @Field('otp') String otp,
    @Field('new_password') String newPassword,
  );

  /// Change password endpoint
  @POST(ApiConstants.changePassword)
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> changePassword(
    @Field('user_id') String userId,
    @Field('old_password') String oldPassword,
    @Field('new_password') String newPassword,
  );

  /// Logout endpoint
  @POST(ApiConstants.logout)
  Future<void> logout();
}

/// Implementation of AuthRemoteDataSource
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRemoteDataSourceRetrofit _retrofit;

  AuthRemoteDataSourceImpl(this._retrofit);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await _retrofit.login(request);
  }

  @override
  Future<SignupResponseModel> signup(SignupRequestModel request) async {
    return await _retrofit.signup(request);
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String mobile) async {
    final response = await _retrofit.forgotPassword(mobile);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp) async {
    final response = await _retrofit.verifyOtp(mobile, otp);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
    String mobile,
    String otp,
    String newPassword,
  ) async {
    final response = await _retrofit.resetPassword(mobile, otp, newPassword);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    final response = await _retrofit.changePassword(userId, oldPassword, newPassword);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> logout() async {
    return await _retrofit.logout();
  }
}
