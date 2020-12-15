import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/data/storage/hive_storage.dart';
import 'package:flutter_base/domain/entities/error_model.dart';

abstract class NetworkManagerInterFace {
  Future<T> requestApi<T>({
    @required String path,
    @required String method,
    data,
    String accept,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    int sendTimeout,
    int receiveTimeout,
    bool usingUserToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
}

class NetworkManager implements NetworkManagerInterFace {
  NetworkManager({this.dio});

  final Dio dio;


  @override
  Future<T> requestApi<T>({String path,
    String method,
    data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    String accept = 'application/json',
    int sendTimeout = 60000,
    int receiveTimeout = 60000,
    bool usingUserToken = false,
    onSendProgress,
    onReceiveProgress}) async {
    // if (usingUserToken) options = await _getOptionsWithToken();
    final token = await HiveStorage.getToken();

    try {
      final Response<T> response = await dio.request<T>(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: Options(
              method: method,
              sendTimeout: sendTimeout,
              receiveTimeout: receiveTimeout,
              headers: {
                'accept': accept,
                // 'Content-Type': 'application/x-www-form-urlencoded',
                'Access-Token': usingUserToken ? token : null,
              }),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      throw ErrorModel.fromJson(e.response.data);
    }
  }
}
