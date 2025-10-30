import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../storage/local_storage.dart';
import '../error/exceptions.dart';

/// API Client for handling HTTP requests using Dio
@lazySingleton
class ApiClient {
  final Dio _dio;
  final LocalStorage _localStorage;

  ApiClient(this._localStorage) : _dio = Dio() {
    _initializeDio();
  }

  /// Initialize Dio with base configuration
  void _initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: {
        'Content-Type': ApiConstants.contentType,
        'Accept': ApiConstants.accept,
      },
    );

    // Add interceptors
    _dio.interceptors.add(_AuthInterceptor(_localStorage));
    _dio.interceptors.add(_LoggingInterceptor());
    _dio.interceptors.add(_ErrorInterceptor());
  }

  /// GET request
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PATCH request
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors and convert to custom exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: 'Request timeout. Please try again.');

      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Server error';

        if (statusCode == 401) {
          return AuthException(message: 'Unauthorized. Please login again.');
        }

        return ServerException(
          message: message,
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');

      default:
        return ServerException(message: 'An unexpected error occurred');
    }
  }

  /// Get Dio instance (for advanced usage)
  Dio get dio => _dio;
}

/// Interceptor for adding auth token to requests
class _AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;

  _AuthInterceptor(this._localStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get auth token from local storage
    final token = await _localStorage.getString('auth_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

/// Interceptor for logging requests and responses
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('REQUEST[${options.method}] => ${options.uri}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}');
    print('Data: ${response.data}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('ERROR[${err.response?.statusCode}] => ${err.requestOptions.uri}');
    print('Message: ${err.message}');
    print('Data: ${err.response?.data}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(err);
  }
}

/// Interceptor for handling common errors
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle common errors here if needed
    handler.next(err);
  }
}
