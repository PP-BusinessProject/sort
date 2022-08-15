// ignore_for_file: sort_constructors_first

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:meta/meta.dart';

import 'utils/logger.dart';

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

@sealed
@immutable
class SortAPI {
  SortAPI._([final BaseOptions? options]) : _dio = Dio(options) {
    _dio.interceptors.add(ExceptionInterceptor());
  }
  final Dio _dio;

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

  Stream<StreamEvent<T>> getStream<T extends Object?>(
    final String path, {
    final T Function(Object? value)? fromJson,
    final Map<String, Object?>? parameters,
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

  Future<T> get<T extends Object?>(
    final String path, {
    final T Function(Object? value)? fromJson,
    final Map<String, Object?>? parameters,
  }) async {
    final Response<Object?> response =
        await _dio.get<Object?>(path, queryParameters: parameters);
    return fromJson != null ? fromJson(response.data) : response.data as T;
  }

  Future<T?> post<T extends Object?>(
    final String path,
    final T value, {
    required final Object? Function(T value) toJson,
    final T Function(Object? value)? fromJson,
    final bool returning = true,
  }) async {
    final Response<Object?> response = await _dio.post<Object?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: toJson(value),
    );
    final Object? data = response.data;
    return data != null && fromJson != null ? fromJson(data) : null;
  }

  Future<T?> put<T extends Object?>(
    final String path,
    final T value, {
    required final Object? Function(T value) toJson,
    final T Function(Object? value)? fromJson,
    final bool returning = true,
  }) async {
    final Response<Object?> response = await _dio.put<Object?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: toJson(value),
    );
    final Object? data = response.data;
    return data != null && fromJson != null ? fromJson(data) : null;
  }

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

/// The type of the event on [SortAPI.getStream].
enum StreamEventType {
  /// Event is a `PING`.
  ping,

  /// Event is a database `INSERT` of the model.
  insert,

  /// Event is a database `UPDATE` of the model.
  update,

  /// Event is a database `DELETE` of the model.
  delete
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

class SortAPIException extends DioError {
  SortAPIException({required final super.requestOptions, final super.response});

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

@immutable
class ExceptionInterceptor extends Interceptor {
  @override
  void onResponse(
    final Response<Object?> response,
    final ResponseInterceptorHandler handler,
  ) {
    final int? statusCode = response.statusCode;
    if (statusCode == null) {
      handler.next(response);
    } else if (statusCode >= 400) {
      final SortAPIException exception = SortAPIException(
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
