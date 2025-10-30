import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';

/// Authentication Local Data Source Interface
abstract class AuthLocalDataSource {
  /// Cache user data
  Future<void> cacheUserData(UserModel user);

  /// Get cached user
  Future<UserModel> getCachedUser();

  /// Cache auth token
  Future<void> cacheAuthToken(String token);

  /// Get auth token
  Future<String> getAuthToken();

  /// Cache login credentials (if remember me is enabled)
  Future<void> cacheCredentials(String username, String password);

  /// Get cached credentials
  Future<Map<String, String>?> getCachedCredentials();

  /// Set remember me flag
  Future<void> setRememberMe(bool remember);

  /// Get remember me flag
  Future<bool> getRememberMe();

  /// Clear all cached data
  Future<void> clearCache();

  /// Check if user is logged in
  Future<bool> isLoggedIn();
}

/// Implementation of AuthLocalDataSource
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage _localStorage;
  final SecureStorage _secureStorage;

  AuthLocalDataSourceImpl(this._localStorage, this._secureStorage);

  @override
  Future<void> cacheUserData(UserModel user) async {
    try {
      // Save user data as JSON string
      final userJson = json.encode(user.toJson());
      await _localStorage.saveString(AppConstants.keyUserId, user.userId);
      await _localStorage.saveString(AppConstants.keyUserName, user.username);
      await _localStorage.saveString(AppConstants.keyUserEmail, user.email ?? '');
      await _localStorage.saveString('user_data', userJson);
      await _localStorage.saveBool(AppConstants.keyIsLoggedIn, true);
    } catch (e) {
      throw CacheException(message: 'Failed to cache user data: $e');
    }
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final userJson = await _localStorage.getString('user_data');
      if (userJson == null || userJson.isEmpty) {
        throw CacheException(message: 'No cached user data found');
      }

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached user: $e');
    }
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    try {
      await _localStorage.saveString(AppConstants.keyAuthToken, token);
    } catch (e) {
      throw CacheException(message: 'Failed to cache auth token: $e');
    }
  }

  @override
  Future<String> getAuthToken() async {
    try {
      final token = await _localStorage.getString(AppConstants.keyAuthToken);
      if (token == null || token.isEmpty) {
        throw CacheException(message: 'No auth token found');
      }
      return token;
    } catch (e) {
      throw CacheException(message: 'Failed to get auth token: $e');
    }
  }

  @override
  Future<void> cacheCredentials(String username, String password) async {
    try {
      await _secureStorage.write(AppConstants.secureKeyEmail, username);
      await _secureStorage.write(AppConstants.secureKeyPassword, password);
    } catch (e) {
      throw CacheException(message: 'Failed to cache credentials: $e');
    }
  }

  @override
  Future<Map<String, String>?> getCachedCredentials() async {
    try {
      final username = await _secureStorage.read(AppConstants.secureKeyEmail);
      final password = await _secureStorage.read(AppConstants.secureKeyPassword);

      if (username == null || password == null) {
        return null;
      }

      return {
        'username': username,
        'password': password,
      };
    } catch (e) {
      throw CacheException(message: 'Failed to get cached credentials: $e');
    }
  }

  @override
  Future<void> setRememberMe(bool remember) async {
    try {
      await _localStorage.saveBool(AppConstants.keyRememberMe, remember);
    } catch (e) {
      throw CacheException(message: 'Failed to set remember me: $e');
    }
  }

  @override
  Future<bool> getRememberMe() async {
    try {
      final remember = await _localStorage.getBool(AppConstants.keyRememberMe);
      return remember ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Clear local storage
      await _localStorage.remove(AppConstants.keyAuthToken);
      await _localStorage.remove(AppConstants.keyUserId);
      await _localStorage.remove(AppConstants.keyUserName);
      await _localStorage.remove(AppConstants.keyUserEmail);
      await _localStorage.remove('user_data');
      await _localStorage.saveBool(AppConstants.keyIsLoggedIn, false);

      // Clear secure storage if remember me is not enabled
      final rememberMe = await getRememberMe();
      if (!rememberMe) {
        await _secureStorage.delete(AppConstants.secureKeyEmail);
        await _secureStorage.delete(AppConstants.secureKeyPassword);
      }
    } catch (e) {
      throw CacheException(message: 'Failed to clear cache: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn = await _localStorage.getBool(AppConstants.keyIsLoggedIn);
      final token = await _localStorage.getString(AppConstants.keyAuthToken);
      return (isLoggedIn ?? false) && (token != null && token.isNotEmpty);
    } catch (e) {
      return false;
    }
  }
}
