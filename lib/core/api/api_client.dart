import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'api_client.g.dart';

// Simple API client without Retrofit for now
// We'll use direct Dio calls to avoid generation issues
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  // Health Data endpoints
  Future<List<Map<String, dynamic>>> getHealthData(String userId) async {
    final response = await _dio.get('/health/data', queryParameters: {'userId': userId});
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> createHealthData(Map<String, dynamic> data) async {
    final response = await _dio.post('/health/data', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateHealthData(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/health/data/$id', data: data);
    return response.data;
  }

  Future<void> deleteHealthData(String id) async {
    await _dio.delete('/health/data/$id');
  }

  // Wealth Data endpoints
  Future<Map<String, dynamic>> getPortfolio(String userId) async {
    final response = await _dio.get('/wealth/portfolio', queryParameters: {'userId': userId});
    return response.data;
  }

  Future<Map<String, dynamic>> createPortfolio(Map<String, dynamic> data) async {
    final response = await _dio.post('/wealth/portfolio', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updatePortfolio(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/wealth/portfolio/$id', data: data);
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getFinancialGoals(String userId) async {
    final response = await _dio.get('/wealth/goals', queryParameters: {'userId': userId});
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> createFinancialGoal(Map<String, dynamic> data) async {
    final response = await _dio.post('/wealth/goals', data: data);
    return response.data;
  }

  // User Profile endpoints
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await _dio.get('/user/profile', queryParameters: {'userId': userId});
    return response.data;
  }

  Future<Map<String, dynamic>> updateUserProfile(Map<String, dynamic> data) async {
    final response = await _dio.put('/user/profile', data: data);
    return response.data;
  }

  // Achievements endpoints
  Future<List<Map<String, dynamic>>> getAchievements(String userId) async {
    final response = await _dio.get('/user/achievements', queryParameters: {'userId': userId});
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> createAchievement(Map<String, dynamic> data) async {
    final response = await _dio.post('/user/achievements', data: data);
    return response.data;
  }

  // Tasks endpoints
  Future<List<Map<String, dynamic>>> getTasks(String userId) async {
    final response = await _dio.get('/user/tasks', queryParameters: {'userId': userId});
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> createTask(Map<String, dynamic> data) async {
    final response = await _dio.post('/user/tasks', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateTask(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/user/tasks/$id', data: data);
    return response.data;
  }

  // AI Recommendations endpoints
  Future<Map<String, dynamic>> getRecommendations(Map<String, dynamic> request) async {
    final response = await _dio.post('/ai/recommendations', data: request);
    return response.data;
  }

  Future<Map<String, dynamic>> getHealthInsights(Map<String, dynamic> request) async {
    final response = await _dio.post('/ai/health-insights', data: request);
    return response.data;
  }

  Future<Map<String, dynamic>> getWealthInsights(Map<String, dynamic> request) async {
    final response = await _dio.post('/ai/wealth-insights', data: request);
    return response.data;
  }

  // Sync endpoints
  Future<Map<String, dynamic>> batchSync(Map<String, dynamic> data) async {
    final response = await _dio.post('/sync/batch', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getSyncStatus(String userId) async {
    final response = await _dio.get('/sync/status', queryParameters: {'userId': userId});
    return response.data;
  }
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  
  // Set base URL
  dio.options.baseUrl = "https://api.empowerapp.com/v1";
  
  // Add interceptors
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (object) {
      // Only log in debug mode
      assert(() {
        print(object);
        return true;
      }());
    },
  ));

  // Add auth interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Add authentication token if available
      // final token = await ref.read(authServiceProvider).getToken();
      // if (token != null) {
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
      handler.next(options);
    },
    onError: (error, handler) async {
      // Handle token refresh or logout on 401
      if (error.response?.statusCode == 401) {
        // Handle unauthorized access
        // await ref.read(authServiceProvider).logout();
      }
      handler.next(error);
    },
  ));

  // Set timeouts
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.sendTimeout = const Duration(seconds: 30);

  return dio;
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.read(dioProvider);
  return ApiClient(dio);
}

// Error handling utilities
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

// API response wrapper
class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;

  const ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      message: message,
      success: true,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode, T? data}) {
    return ApiResponse(
      data: data,
      message: message,
      success: false,
      statusCode: statusCode,
    );
  }
}

// API helper functions
Future<ApiResponse<T>> handleApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final result = await apiCall();
    return ApiResponse.success(result);
  } on DioException catch (e) {
    return _handleDioException<T>(e);
  } catch (e) {
    return ApiResponse.error('Unexpected error: $e');
  }
}

ApiResponse<T> _handleDioException<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ApiResponse.error('Connection timeout', statusCode: e.response?.statusCode);
    case DioExceptionType.sendTimeout:
      return ApiResponse.error('Send timeout', statusCode: e.response?.statusCode);
    case DioExceptionType.receiveTimeout:
      return ApiResponse.error('Receive timeout', statusCode: e.response?.statusCode);
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data?['message'] ?? 'Server error';
      return ApiResponse.error(message, statusCode: statusCode);
    case DioExceptionType.cancel:
      return ApiResponse.error('Request cancelled');
    case DioExceptionType.connectionError:
      return ApiResponse.error('Connection error. Please check your internet connection.');
    case DioExceptionType.badCertificate:
      return ApiResponse.error('Certificate error');
    case DioExceptionType.unknown:
      return ApiResponse.error('Unknown error: ${e.message}');
  }
}