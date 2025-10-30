// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/data/datasources/auth_local_datasource.dart'
    as _i1040;
import '../../features/authentication/data/datasources/auth_remote_datasource.dart'
    as _i14;
import '../../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i317;
import '../../features/authentication/di/auth_module.dart' as _i720;
import '../../features/authentication/domain/repositories/auth_repository.dart'
    as _i742;
import '../../features/authentication/domain/usecases/change_password_usecase.dart'
    as _i526;
import '../../features/authentication/domain/usecases/check_login_status_usecase.dart'
    as _i59;
import '../../features/authentication/domain/usecases/forgot_password_usecase.dart'
    as _i963;
import '../../features/authentication/domain/usecases/get_current_user_usecase.dart'
    as _i455;
import '../../features/authentication/domain/usecases/login_usecase.dart'
    as _i995;
import '../../features/authentication/domain/usecases/logout_usecase.dart'
    as _i1067;
import '../../features/authentication/domain/usecases/reset_password_usecase.dart'
    as _i318;
import '../../features/authentication/domain/usecases/signup_usecase.dart'
    as _i712;
import '../../features/authentication/domain/usecases/verify_otp_usecase.dart'
    as _i173;
import '../network/api_client.dart' as _i557;
import '../network/network_info.dart' as _i932;
import '../storage/local_storage.dart' as _i329;
import '../storage/secure_storage.dart' as _i619;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final authModule = _$AuthModule();
    gh.lazySingleton<_i329.LocalStorage>(
      () => _i329.LocalStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i14.AuthRemoteDataSourceRetrofit>(
      () => authModule.provideAuthRemoteDataSourceRetrofit(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i14.AuthRemoteDataSource>(
      () => _i14.AuthRemoteDataSourceImpl(
        gh<_i14.AuthRemoteDataSourceRetrofit>(),
      ),
    );
    gh.lazySingleton<_i619.SecureStorage>(
      () => _i619.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i557.ApiClient>(
      () => _i557.ApiClient(gh<_i329.LocalStorage>()),
    );
    gh.lazySingleton<_i1040.AuthLocalDataSource>(
      () => _i1040.AuthLocalDataSourceImpl(
        gh<_i329.LocalStorage>(),
        gh<_i619.SecureStorage>(),
      ),
    );
    gh.lazySingleton<_i742.AuthRepository>(
      () => _i317.AuthRepositoryImpl(
        gh<_i14.AuthRemoteDataSource>(),
        gh<_i1040.AuthLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i526.ChangePasswordUseCase>(
      () => _i526.ChangePasswordUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i59.CheckLoginStatusUseCase>(
      () => _i59.CheckLoginStatusUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i963.ForgotPasswordUseCase>(
      () => _i963.ForgotPasswordUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i455.GetCurrentUserUseCase>(
      () => _i455.GetCurrentUserUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i995.LoginUseCase>(
      () => _i995.LoginUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i1067.LogoutUseCase>(
      () => _i1067.LogoutUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i318.ResetPasswordUseCase>(
      () => _i318.ResetPasswordUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i712.SignupUseCase>(
      () => _i712.SignupUseCase(gh<_i742.AuthRepository>()),
    );
    gh.lazySingleton<_i173.VerifyOtpUseCase>(
      () => _i173.VerifyOtpUseCase(gh<_i742.AuthRepository>()),
    );
    return this;
  }
}

class _$AuthModule extends _i720.AuthModule {}
