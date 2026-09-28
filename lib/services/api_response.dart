import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  final bool success;
  final T? data;
  final int statusCode;
  final String? message;
  final Map<String, dynamic>? error;
  final String? timestamp;

  const ApiResponse({
    required this.success,
    required this.statusCode,
    this.data,
    this.message,
    this.error,
    this.timestamp,
  });

  static ApiResponse<dynamic> fromDioResponse(Response<dynamic> response) {
    final status = response.statusCode ?? 0;
    final dynamic decoded = response.data;

    var success = false;
    dynamic data;
    String? message;

    Map<String, dynamic>? error;
    String? timestamp;

    if (decoded is Map) {
      if (decoded.containsKey('success')) {
        success = decoded['success'] == true;
      } else if (decoded.containsKey('status')) {
        success = decoded['status'] == true;
      } else {
        success = status >= 200 && status < 300;
      }

      data = decoded.containsKey('data') ? decoded['data'] : decoded;

      final rawError = decoded['error'];
      if (!success && rawError is Map) {
        error = rawError.map((k, v) => MapEntry(k.toString(), v));
        final topLevelMessage = decoded['message'];
        final description = rawError['description'];
        message =
            (topLevelMessage is String && topLevelMessage.trim().isNotEmpty)
            ? topLevelMessage
            : (description is String && description.trim().isNotEmpty
                  ? description
                  : null);
      } else {
        message = decoded['message'] as String?;
      }
      final rawErrors = decoded['errors'];
      if (!success && error == null && rawErrors is Map) {
        error = rawErrors.map((k, v) => MapEntry(k.toString(), v));
        if (message == null || message.trim().isEmpty) {
          final title = decoded['title'];
          if (title is String && title.trim().isNotEmpty) {
            message = title;
          }
        }
      }

      final rawTimestamp = decoded['timestamp'];
      if (rawTimestamp != null) {
        timestamp = rawTimestamp.toString();
      }
    } else if (decoded is List) {
      success = status >= 200 && status < 300;
      data = decoded;
    } else {
      success = status >= 200 && status < 300;
      data = decoded;
    }

    return ApiResponse<dynamic>(
      success: success,
      statusCode: status,
      data: data,
      message: message,
      error: error,
      timestamp: timestamp,
    );
  }

  static ApiResponse<dynamic> fromHttpResponse(http.Response response) {
    final status = response.statusCode;
    dynamic decoded;
    try {
      decoded = response.body.isNotEmpty ? json.decode(response.body) : null;
    } catch (_) {
      decoded = null;
    }

    var success = false;
    dynamic data;
    String? message;

    Map<String, dynamic>? error;
    String? timestamp;

    if (decoded is Map) {
      if (decoded.containsKey('success')) {
        success = decoded['success'] == true;
      } else if (decoded.containsKey('status')) {
        success = decoded['status'] == true;
      } else {
        success = status >= 200 && status < 300;
      }

      data = decoded.containsKey('data') ? decoded['data'] : decoded;

      final rawError = decoded['error'];
      if (!success && rawError is Map) {
        error = rawError.map((k, v) => MapEntry(k.toString(), v));
        final topLevelMessage = decoded['message'];
        final description = rawError['description'];
        message =
            (topLevelMessage is String && topLevelMessage.trim().isNotEmpty)
            ? topLevelMessage
            : (description is String && description.trim().isNotEmpty
                  ? description
                  : null);
      } else {
        message = decoded['message'] as String?;
      }
      final rawErrors = decoded['errors'];
      if (!success && error == null && rawErrors is Map) {
        error = rawErrors.map((k, v) => MapEntry(k.toString(), v));
        if (message == null || message.trim().isEmpty) {
          final title = decoded['title'];
          if (title is String && title.trim().isNotEmpty) {
            message = title;
          }
        }
      }

      final rawTimestamp = decoded['timestamp'];
      if (rawTimestamp != null) {
        timestamp = rawTimestamp.toString();
      }
    } else if (decoded is List) {
      success = status >= 200 && status < 300;
      data = decoded;
    } else {
      success = status >= 200 && status < 300;
      data = decoded;
    }

    return ApiResponse<dynamic>(
      success: success,
      statusCode: status,
      data: data,
      message: message,
      error: error,
      timestamp: timestamp,
    );
  }
}
