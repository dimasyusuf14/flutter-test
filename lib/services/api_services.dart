
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test_gias/services/api_response.dart';
import 'package:flutter_test_gias/utilities/api_constant.dart';
import 'package:get/get.dart' as get_pkg;
import 'package:get_storage/get_storage.dart';


enum APIMethod { post, get, delete, put }

class ApiServices extends get_pkg.GetxService {
  late final Dio _dio;
  late CancelToken _cancelToken;


  Dio get dio => _dio;

  static ApiServices get to => get_pkg.Get.find();

  static Future<ApiResponse<dynamic>> api({
    dynamic requestBody,
    Map<String, dynamic>? requestBodyMap,
    required String endPoint,
    bool withToken = true,
    bool isReponseEmpty = false,
    bool isLogin = false,
    String param = '',
    int version = 1,
    required APIMethod type,
    Map<String, String> additionalHeaders = const {},
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!get_pkg.Get.isRegistered<ApiServices>()) {
      get_pkg.Get.put(ApiServices());
    }

    return get_pkg.Get.find<ApiServices>()._makeRequest(
      requestBody: requestBody ?? requestBodyMap,
      endPoint: endPoint,
      withToken: withToken,
      isReponseEmpty: isReponseEmpty,
      isLogin: isLogin,
      param: param,
      version: version,
      type: type,
      additionalHeaders: additionalHeaders,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _cancelToken = CancelToken();
    _dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void cancelAllRequest() {
    try {
      if (!_cancelToken.isCancelled) {
        _cancelToken.cancel('unauthorized_request');
      }
    } catch (_) {}
    _cancelToken = CancelToken();
  }

  int? _extractBodyStatusCode(dynamic data) {
    if (data is Map) {
      final err = data['error'];
      if (err is Map) {
        final sc = err['statusCode'];
        if (sc is num) {
          return sc.toInt();
        }
        if (sc is String) {
          return int.tryParse(sc);
        }
      }
    }
    return null;
  }

  String? _extractBodyMessage(dynamic data) {
    if (data is Map) {
      final msg = data['message'];
      if (msg is String && msg.trim().isNotEmpty) {
        return msg;
      }
      final err = data['error'];
      if (err is Map) {
        final em = err['message'] ?? err['description'];
        if (em is String && em.trim().isNotEmpty) {
          return em;
        }
      }
    }
    return null;
  }

  bool _isUnauthorizedBody(dynamic data, int? httpStatusCode) {
    if (httpStatusCode == 401) {
      return true;
    }
    if (data is Map) {
      final code = data['code'];
      if (code is String && code.toUpperCase() == 'UNAUTHORIZED') {
        return true;
      }
      final err = data['error'];
      if (err is Map) {
        final errCode = err['code'];
        if (errCode is String && errCode.toUpperCase() == 'INVALID_TOKEN') {
          return true;
        }
        final sc = _extractBodyStatusCode(data);
        if (sc == 401) {
          return true;
        }
      }
    }

    if (data is Map && data['success'] == false && data['error'] != null) {
      debugPrint(
        'ApiServices: Response has error but not detected as unauthorized. '
        'StatusCode: $httpStatusCode, Data: $data',
      );
    }

    return false;
  }

  void _throwUnauthorized({
    int? statusCode,
    String? message,
    bool isLogin = false,
  }) {
    cancelAllRequest();

    throw AuthException(
      message: message ?? 'Unauthorized',
      statusCode: statusCode,
    );
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
          debugPrint('HEADERS: ${options.headers}');
          if (options.data != null) {
            debugPrint('BODY: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          debugPrint('RESPONSE BODY: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Future<ApiResponse<dynamic>> _makeRequest({
    dynamic requestBody,
    required String endPoint,
    bool withToken = true,
    bool isReponseEmpty = false,
    bool isLogin = false,
    String param = '',
    int version = 1,
    required APIMethod type,
    Map<String, String> additionalHeaders = const {},
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final headers = <String, String>{};

    if (withToken) {
      final box = GetStorage();
      final token = box.read<String>('token');
      final email = box.read<String>('emailAddress');

      if (token != null && email != null) {
        headers.addAll({'email': email, 'token': token});
      }
    }

    headers.addAll(additionalHeaders);

    String path;
    if (version == 1) {
      path = '/api$endPoint$param';
    } else {
      path = '/api/v$version$endPoint$param';
    }

    try {
      Response<dynamic> response;
      final options = Options(headers: headers);
      final dynamic data = requestBody;
      final cancelToken = _cancelToken;

      switch (type) {
        case APIMethod.post:
          response = await _dio.post(
            path,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case APIMethod.get:
          response = await _dio.get(
            path,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case APIMethod.put:
          response = await _dio.put(
            path,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case APIMethod.delete:
          response = await _dio.delete(
            path,
            options: options,
            cancelToken: cancelToken,
          );
          break;
      }

      final dataBody = response.data;
      final httpStatusCode = response.statusCode;
      if (_isUnauthorizedBody(dataBody, httpStatusCode) && withToken) {
        _throwUnauthorized(
          statusCode: httpStatusCode ?? _extractBodyStatusCode(dataBody),
          message: _extractBodyMessage(dataBody),
          isLogin: isLogin,
        );
      }
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel &&
          (e.message?.contains('auth_unauthorized') ?? false)) {
        _throwUnauthorized(statusCode: 401, isLogin: isLogin);
      }

      // Timeout & connection error
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiResponse(
            success: false,
            statusCode: 408,
            message: 'Request timed out. Please try again.',
          );
        case DioExceptionType.connectionError:
          return ApiResponse(
            success: false,
            statusCode: 503,
            message: 'No internet connection. Please try again.',
          );
        default:
          break;
      }

      // Ada response dari server
      if (e.response != null) {
        final resp = e.response!;
        final data = resp.data;
        final httpStatusCode = resp.statusCode;
        if (_isUnauthorizedBody(data, httpStatusCode) && withToken) {
          _throwUnauthorized(
            statusCode: httpStatusCode ?? _extractBodyStatusCode(data),
            message: _extractBodyMessage(data),
            isLogin: isLogin,
          );
        }
        return ApiResponse.fromDioResponse(resp);
      }

      // Fallback - tidak ada response sama sekali
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: 'Something went wrong. Please try again.',
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: 'Something went wrong. Please try again.',
      );
    }
  }
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException({this.message = 'Unauthorized', this.statusCode});

  @override
  String toString() {
    return 'AuthException(statusCode: $statusCode, message: $message)';
  }
}