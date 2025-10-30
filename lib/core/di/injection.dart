import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.config.dart';

/// Global instance of GetIt for dependency injection
final getIt = GetIt.instance;

/// Initialize dependencies
/// Call this in main.dart before runApp()
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  // Register external dependencies
  await _registerExternalDependencies();

  // Initialize injectable dependencies
  getIt.init();
}

/// Register external dependencies that need async initialization
Future<void> _registerExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // FlutterSecureStorage
  const flutterSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => flutterSecureStorage,
  );

  // Connectivity
  final connectivity = Connectivity();
  getIt.registerLazySingleton<Connectivity>(() => connectivity);

  // Dio
  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);
}
