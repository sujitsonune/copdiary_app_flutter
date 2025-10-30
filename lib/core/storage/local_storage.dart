import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exceptions.dart';

/// Local Storage wrapper for SharedPreferences
@lazySingleton
class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  /// Save String value
  Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save string: $key');
    }
  }

  /// Get String value
  Future<String?> getString(String key) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      throw CacheException(message: 'Failed to get string: $key');
    }
  }

  /// Save int value
  Future<bool> saveInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save int: $key');
    }
  }

  /// Get int value
  Future<int?> getInt(String key) async {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      throw CacheException(message: 'Failed to get int: $key');
    }
  }

  /// Save double value
  Future<bool> saveDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save double: $key');
    }
  }

  /// Get double value
  Future<double?> getDouble(String key) async {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      throw CacheException(message: 'Failed to get double: $key');
    }
  }

  /// Save bool value
  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save bool: $key');
    }
  }

  /// Get bool value
  Future<bool?> getBool(String key) async {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      throw CacheException(message: 'Failed to get bool: $key');
    }
  }

  /// Save List<String> value
  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      throw CacheException(message: 'Failed to save string list: $key');
    }
  }

  /// Get List<String> value
  Future<List<String>?> getStringList(String key) async {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      throw CacheException(message: 'Failed to get string list: $key');
    }
  }

  /// Remove value by key
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      throw CacheException(message: 'Failed to remove key: $key');
    }
  }

  /// Clear all values
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      throw CacheException(message: 'Failed to clear storage');
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Get all keys
  Set<String> getAllKeys() {
    return _prefs.getKeys();
  }

  /// Reload preferences (useful after external changes)
  Future<void> reload() async {
    try {
      await _prefs.reload();
    } catch (e) {
      throw CacheException(message: 'Failed to reload preferences');
    }
  }
}
