import 'package:dio/dio.dart';
import 'package:fsi_app/utils/constants.dart';
import 'package:fsi_app/utils/endpoints.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiBasics {
  static Future makeGetRequest(url, headers) async {
    var _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestBody: true,
      compact: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
    return await _dio
        .get(url, options: Options(headers: await _getHeader() ?? headers))
        .then((value) => value.data);
  }

  static Future makePostRequest(url, data, headers) async {
    var _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true));
    return await _dio
        .post(url,
            data: FormData.fromMap(data),
            options: Options(
                headers: headers == null ? await _getHeader() : headers))
        .then((value) => value.data);
  }

  static Future makePutRequest(url, data, headers) async {
    var _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true));
    return await _dio.put(url,
        data: FormData.fromMap(data),
        options:
            Options(headers: headers == null ? await _getHeader() : headers));
  }

  static Future makeDeleteRequest(url, data, id, headers) async {
    var _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true));
    return await _dio.delete(url + "/$id",
        data: FormData.fromMap(data),
        options: Options(headers: await _getHeader()));
  }
}

Future _getHeader() async {
  return {
    'Authorization': 'Bearer $sandboxKey',
    'Content-Type': 'application/json'
  };
}
