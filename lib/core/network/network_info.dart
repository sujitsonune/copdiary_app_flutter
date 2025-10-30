import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Abstract class for network connectivity checking
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using connectivity_plus package
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();

  NetworkInfoImpl(this._connectivity) {
    _init();
  }

  /// Initialize connectivity monitoring
  void _init() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final isConnected = _checkConnectivity(results);
      _connectivityController.add(isConnected);
    });
  }

  /// Check if device is connected to internet
  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _checkConnectivity(result);
  }

  /// Stream that emits connectivity changes
  @override
  Stream<bool> get onConnectivityChanged => _connectivityController.stream;

  /// Check connectivity from ConnectivityResult list
  bool _checkConnectivity(List<ConnectivityResult> results) {
    // If any result is not none, we have connectivity
    return results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn);
  }

  /// Dispose resources
  void dispose() {
    _connectivityController.close();
  }
}
