import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../error/exceptions.dart';

/// Secure Storage wrapper for FlutterSecureStorage
/// Used for storing sensitive data like passwords, tokens, etc.
@lazySingleton
class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  /// Write secure value
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw CacheException(message: 'Failed to write secure data: $key');
    }
  }

  /// Read secure value
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw CacheException(message: 'Failed to read secure data: $key');
    }
  }

  /// Delete secure value
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw CacheException(message: 'Failed to delete secure data: $key');
    }
  }

  /// Delete all secure values
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw CacheException(message: 'Failed to delete all secure data');
    }
  }

  /// Read all secure values
  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      throw CacheException(message: 'Failed to read all secure data');
    }
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      throw CacheException(message: 'Failed to check key: $key');
    }
  }
}
