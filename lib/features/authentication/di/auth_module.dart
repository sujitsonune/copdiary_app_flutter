import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/datasources/auth_remote_datasource.dart';

/// Authentication Feature Dependency Injection Module
@module
abstract class AuthModule {
  /// Provide AuthRemoteDataSourceRetrofit
  @lazySingleton
  AuthRemoteDataSourceRetrofit provideAuthRemoteDataSourceRetrofit(Dio dio) {
    return AuthRemoteDataSourceRetrofit(dio);
  }
}
