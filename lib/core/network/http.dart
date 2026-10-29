import 'dart:async';

import 'package:cesc01/core/network/base/header/auth_interceptor.dart';
import 'package:cesc01/core/network/base/interceptor/mock/mock_interceptor.dart';
import 'package:cesc01/core/network/base/interceptor/network_status/network_status.dart';
import 'package:cesc01/core/network/base/interceptor/network_status/network_status_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'base/base_options.dart' show baseDioOptions;
import 'base/httpClientAdapter.dart' show httpAdapter;

class Http {
  static final Http _instance = Http._internal();
  static Http get instance => Http();
  factory Http() => _instance;

  late Dio _dio;
  CancelToken cancelTokenAll = CancelToken();

  /// 网络质量监听订阅
  StreamSubscription<NetworkQuality>? _qualitySub;

  Http._internal() {
    _dio = Dio(baseDioOptions);
    _dio.httpClientAdapter = httpAdapter;
    _setupInterceptors();
    _setupNetworkQualityListener();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(AuthInterceptor());

    ///todo mock
    _dio.interceptors.add(MockInterceptor());
    _dio.interceptors.add(NetworkStatusInterceptor(dioGetter: () => _dio));
    if (kDebugMode) {
      _dio.interceptors.add(prettyDioLogger);
    }
  }

  /// 监听网络质量变化，动态调整超时时间
  void _setupNetworkQualityListener() {
    _qualitySub = NetworkStatusService.instance.qualityStream.listen((quality) {
      debugPrint('[ApiClient] 网络质量变化: $quality，动态调整超时配置');
      _dio.options.connectTimeout =
          NetworkStatusService.instance.connectTimeout;
      _dio.options.receiveTimeout =
          NetworkStatusService.instance.receiveTimeout;
    });
  }

  void cancelALLRequests() {
    cancelTokenAll.cancel("cancel all request");
  }

  /// 释放资源
  void dispose() {
    _qualitySub?.cancel();
  }

  PrettyDioLogger prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
  );

  ///post
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    bool showError = false,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? cancelTokenAll,
        onSendProgress: onSendProgress,
      );
      return response.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///get
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _dio.get(
        url,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken ?? cancelTokenAll,
      );
      return result.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///put
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    bool showError = false,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? cancelTokenAll,
        onSendProgress: onSendProgress,
      );
      return response.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }
}
