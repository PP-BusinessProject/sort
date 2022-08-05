// ignore_for_file: sort_constructors_first

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import 'utils/logger.dart';

final Provider<SortAPI> sortApiProvider = Provider<SortAPI>(
  (final _) => SortAPI._(
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

  Stream<StreamEvent<T, V>> getStream<T extends Object, V extends Object>(
    final String path, {
    final JsonConverter<T, V>? converter,
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
            yield StreamEvent<T, V>.fromJson(
              String.fromCharCodes(data),
              converter: converter,
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

  Future<T> get<T extends Object, V extends Object>(
    final String path, {
    final JsonConverter<T, V>? converter,
    final V Function(Object? value)? cast,
    final Map<String, Object?>? parameters,
  }) async {
    final Response<Object?> response =
        await _dio.get<Object?>(path, queryParameters: parameters);
    return converter != null
        ? converter
            .fromJson(cast != null ? cast(response.data) : response.data! as V)
        : response.data! as T;
  }

  Future<Iterable<T>> post<T extends Object>(
    final String path,
    final Iterable<T> value,
    final JsonConverter<T, Map<String, Object?>> converter, {
    final bool returning = true,
  }) async {
    final Response<Iterable<Object?>?> response =
        await _dio.post<Iterable<Object?>?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: IterableConverter<T, Map<String, Object?>>(converter)
          .toJson(value)
          .toList(growable: false),
    );
    final Iterable<Object?>? data = response.data;
    return data != null
        ? IterableConverter<T, Map<String, Object?>>(converter)
            .fromJson(data.cast<Map<String, Object?>>())
        : <T>[];
  }

  Future<Iterable<T>> put<T extends Object>(
    final String path,
    final Iterable<T> value,
    final JsonConverter<T, Map<String, Object?>> converter, {
    final bool returning = true,
  }) async {
    final Response<Iterable<Object?>?> response =
        await _dio.put<Iterable<Object?>?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      data: IterableConverter<T, Map<String, Object?>>(converter)
          .toJson(value)
          .toList(growable: false),
    );
    final Iterable<Object?>? data = response.data;
    return data != null
        ? IterableConverter<T, Map<String, Object?>>(converter)
            .fromJson(data.cast<Map<String, Object?>>())
        : <T>[];
  }

  Future<Iterable<T>> delete<T extends Object>(
    final String path, {
    final JsonConverter<T, Map<String, Object?>>? converter,
    final Map<String, Object?>? parameters,
    final bool returning = true,
  }) async {
    final Response<Iterable<Object?>?> response =
        await _dio.delete<Iterable<Object?>?>(
      returning ? (path.endsWith('/return') ? path : '$path/return') : path,
      queryParameters: parameters,
    );
    final Iterable<Object?>? data = response.data;
    return data != null && converter != null
        ? IterableConverter<T, Map<String, Object?>>(converter)
            .fromJson(data.cast<Map<String, Object?>>())
        : <T>[];
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
class StreamEvent<T extends Object, V extends Object> {
  /// The event on [SortAPI.getStream].
  const StreamEvent({
    required final this.type,
    required final this.value,
    required final this.timestamp,
    final this.converter,
  });

  /// The type of this event.
  final StreamEventType type;

  /// The value of this event.
  final Iterable<T> value;

  /// The converter of the [value] of this event.
  final JsonConverter<T, V>? converter;

  /// The timestamp of this event.
  final DateTime timestamp;

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        'type': const EnumConverter(StreamEventType.values).toJson(type),
        'value': converter != null
            ? IterableConverter<T, V>(converter!).toJson(value)
            : value,
        'timestamp': dateTimeConverter.toJson(timestamp),
      };

  /// Convert the map with string keys to this model.
  factory StreamEvent.fromMap(
    final Map<String, Object?> map, {
    final JsonConverter<T, V>? converter,
  }) =>
      StreamEvent<T, V>(
        type: const EnumConverter(StreamEventType.values)
            .fromJson(map['type']! as String),
        value: converter != null
            ? IterableConverter<T, V>(converter)
                .fromJson((map['value']! as Iterable<Object?>).cast<V>())
            : (map['value']! as Iterable<Object?>).cast<T>(),
        converter: converter,
        timestamp: dateTimeConverter.fromJson(map['timestamp']! as String),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory StreamEvent.fromJson(
    final String source, {
    final JsonConverter<T, V>? converter,
  }) =>
      StreamEvent<T, V>.fromMap(
        json.decode(source)! as Map<String, Object?>,
        converter: converter,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is StreamEvent &&
          other.type == type &&
          other.value == value &&
          other.timestamp == timestamp;

  @override
  int get hashCode => type.hashCode ^ value.hashCode ^ timestamp.hashCode;

  @override
  String toString() =>
      'StreamEvent(type: $type, value: $value, timestamp: $timestamp)';
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
