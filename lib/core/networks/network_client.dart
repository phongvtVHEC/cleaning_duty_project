import 'dart:io';
import 'package:cleaning_duty_project/core/errors/exceptions.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  final Dio dio;
  final SecureStorageImpl secureStorageImpl;

  NetworkClient({required this.dio, required this.secureStorageImpl});

  Future<Response> invoke(String url, RequestType requestType,
      {Map<String, String>? queryParameters, dynamic requestBody}) async {
    String accessToken = await secureStorageImpl.getAccessToken() ?? '';
    Response response;
    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      switch (requestType) {
        case RequestType.get:
          response = await dio.get(url,
              queryParameters: queryParameters,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.post:
          response = await dio.post(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.put:
          response = await dio.put(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.delete:
          response = await dio.delete(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.patch:
          response = await dio.patch(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
      }
      return response;
    } on DioException catch (dioError) {
      throw ServerException(dioError: dioError);
    } on SocketException {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete, patch }
