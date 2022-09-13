// ignore_for_file: sort_constructors_first

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:meta/meta.dart';

import 'utils/logger.dart';

/// The api on the [https://sort-api.herokuapp.com/].
final SortAPI sortApi = SortAPI._(
  BaseOptions(
    baseUrl: 'https://sort-api.herokuapp.com',
    validateStatus: (final int? statusCode) => statusCode != null,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 30).inMilliseconds,
    sendTimeout: const Duration(seconds: 30).inMilliseconds,
    receiveTimeout: const Duration(seconds: 30).inMilliseconds,
    maxRedirects: 0,
    receiveDataWhenStatusError: true,
  ),
);

/// The api on the [https://sort-api.herokuapp.com/].
@sealed
@immutable
class SortAPI {
  SortAPI._([final BaseOptions? options]) : _dio = Dio(options) {
    _dio.interceptors.add(ExceptionInterceptor._());
  }
  final Dio _dio;

  /// Return the count of values on [path] with [parameters].
  ///
  /// - **path**: The local path on this api to get events from.
  /// - **parameters**: The parameters on the [path] request.
  Future<int> getCount(
    final String path, {
    final Map<String, Object?>? parameters,
  }) async {
    final Response<String> response = await _dio.get<String>(
      path.endsWith('/count') ? path : '$path/count',
      queryParameters: parameters,
      options: Options(responseType: ResponseType.plain),
    );
    return int.parse(response.data!);
  }

  /// Return the [Stream] of events on [path] with [parameters].
  ///
  /// - **path**: The local path on this api to get events from.
  /// - **parameters**: The parameters on the [path] request.
  /// - **fromJson**: The convertion function used to convert received value.
  /// - **suppress**: If this is true, any errors on [Stream] are ignored and
  /// [Stream] is requested indefinetely.
  Stream<StreamEvent<T>> getStream<T extends Object?>(
    final String path, {
    final Map<String, Object?>? parameters,
    final T Function(Object? value)? fromJson,
    final bool suppress = false,
  }) async* {
    final String $path =
        path.endsWith('/stream') ? path.substring(0, path.length - 7) : path;
    for (;;) {
      try {
        final Response<ResponseBody> response = await _dio.get<ResponseBody>(
          '${$path}/stream',
          queryParameters: parameters,
          options: Options(
            responseType: ResponseType.stream,
            receiveTimeout: 0,
          ),
        );
        if (response.data != null) {
          await for (final Uint8List data in response.data!.stream) {
            yield StreamEvent<T>.fromJson(
              String.fromCharCodes(data),
              fromJson: fromJson,
            );
          }
        }
      } on Exception catch (exception) {
        if (suppress) {
          logger.e('Exception occured while streaming "${$path}".', exception);
          continue;
        } else {
          rethrow;
        }
      }
      break;
    }
  }

  /// Return the value of type [T] on [path] with [parameters].
  ///
  /// - **path**: The local path on this api to get value of type [T] from.
  /// - **parameters**: The parameters on the [path] request.
  /// - **fromJson**: The convertion function used to convert received value.
  Future<T> get<T extends Object?>(
    final String path, {
    final Map<String, Object?>? parameters,
    final T Function(Object? value)? fromJson,
  }) async {
    final Response<Object?> response =
        await _dio.get<Object?>(path, queryParameters: parameters);
    return fromJson != null ? fromJson(response.data) : response.data as T;
  }

  /// Send the [value] of type [T] to [path], optionally [returning] it.
  ///
  /// - **path**: The local path on this api to send the [value] to.
  /// - **value**: The value to send to [path].
  /// - **toJson**: The convertion function used to convert sent [value].
  /// - **fromJson**: The convertion function used to convert received value.
  /// - **returning**: If the sent value should be returned from [path].
  ///     - If this is `false`, the return value is always null.
  Future<T?> post<T extends Object?>(
    final String path,
    final T value, {
    required final Object? Function(T value) toJson,
    final T Function(Object? value)? fromJson,
    final bool returning = false,
  }) async {
    final Response<Object?> response = await _dio.post<Object?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: toJson(value),
    );
    final Object? data = response.data;
    return data != null && fromJson != null ? fromJson(data) : null;
  }

  /// Update the [value] of type [T] on [path], optionally [returning] it.
  ///
  /// - **path**: The local path on this api to update the [value] on.
  /// - **value**: The value to update on [path].
  /// - **toJson**: The convertion function used to convert sent [value].
  /// - **fromJson**: The convertion function used to convert received value.
  /// - **returning**: If the updated [value] should be returned from [path].
  ///     - If this is `false`, the return value is always `null`.
  Future<T?> put<T extends Object?>(
    final String path,
    final T value, {
    required final Object? Function(T value) toJson,
    final T Function(Object? value)? fromJson,
    final bool returning = false,
  }) async {
    final Response<Object?> response = await _dio.put<Object?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: toJson(value),
    );
    final Object? data = response.data;
    return data != null && fromJson != null ? fromJson(data) : null;
  }

  /// Delete the value of type [T] defined by [parameters] on [path],
  /// optionally [returning] it.
  ///
  /// - **path**: The local path on this api to get events from.
  /// - **fromJson**: The convertion function used to convert received value.
  /// - **returning**: If the deleted value should be returned from [path].
  ///     - If this is `false`, the return value is always `null`.
  Future<T?> delete<T extends Object>(
    final String path, {
    final T Function(Object? value)? fromJson,
    final Map<String, Object?>? parameters,
    final bool returning = true,
  }) async {
    final Response<Object?> response = await _dio.delete<Object?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      queryParameters: parameters,
    );
    final Object? data = response.data;
    return data != null && fromJson != null ? fromJson(data) : null;
  }
}

/// The event on [SortAPI.getStream].
@sealed
@immutable
class StreamEvent<T extends Object?> {
  /// The event on [SortAPI.getStream].
  const StreamEvent._({
    required final this.prevValue,
    required final this.value,
    required final this.timestamp,
  });

  /// The previous value of this event.
  final T prevValue;

  /// The value of this event.
  final T value;

  /// The timestamp of this event.
  final DateTime timestamp;

  /// Convert the map with string keys to this model.
  factory StreamEvent.fromMap(
    final Map<String, Object?> map, {
    final T Function(Object? value)? fromJson,
  }) =>
      StreamEvent<T>._(
        prevValue: fromJson != null
            ? fromJson(map['prev_value'])
            : map['prev_value'] as T,
        value: fromJson != null ? fromJson(map['value']) : map['value'] as T,
        timestamp: dateTimeConverter.fromJson(map['timestamp']! as String),
      );

  /// Convert the json string to this model.
  factory StreamEvent.fromJson(
    final String source, {
    final T Function(Object? value)? fromJson,
  }) =>
      StreamEvent<T>.fromMap(
        json.decode(source)! as Map<String, Object?>,
        fromJson: fromJson,
      );

  @override
  String toString() => 'StreamEvent(prevValue: $prevValue, value: $value, '
      'timestamp: $timestamp)';
}

/// The exception on the [SortAPI].
class SortAPIException extends DioError {
  /// The exception on the [SortAPI].
  SortAPIException._({
    required final super.requestOptions,
    final super.response,
  });

  /// The data of this exception.
  Map<String, Object?>? get data => response?.data is Map<String, Object?>
      ? response!.data! as Map<String, Object?>
      : null;

  @override
  String get message => data?['detail'] as String? ?? '';

  @override
  String toString() {
    String msg = 'API Exception: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}

/// The exception interceptor of the [SortAPI].
@immutable
class ExceptionInterceptor extends Interceptor {
  ExceptionInterceptor._();

  @override
  void onResponse(
    final Response<Object?> response,
    final ResponseInterceptorHandler handler,
  ) {
    final int? statusCode = response.statusCode;
    if (statusCode == null) {
      handler.next(response);
    } else if (statusCode >= 400) {
      final SortAPIException exception = SortAPIException._(
        requestOptions: response.requestOptions,
        response: response,
      );
      logger.e(
        exception.toString(),
        exception,
        exception.stackTrace,
      );
      handler.reject(exception, true);
    } else if (statusCode >= 300) {
      final Object? data = response.data;
      if (data is Map<String, Object?>) {
        final String? detail = data['detail'] as String?;
        if (detail != null) {
          logger.w(detail);
        }
      }
      handler.next(response);
    } else {
      handler.next(response);
    }
  }
}
