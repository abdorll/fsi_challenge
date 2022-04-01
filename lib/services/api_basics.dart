import 'package:dio/dio.dart';
import 'package:fsi_app/utils/endpoints.dart';
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
        .get(url,
            options: Options(
                sendTimeout: 30000, headers: await _getHeader() ?? headers))
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
                sendTimeout: 30000, headers: await _getHeader() ?? headers))
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
        options: Options(
            sendTimeout: 30000, headers: await _getHeader() ?? headers));
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
        options: Options(
            sendTimeout: 30000, headers: await _getHeader() ?? headers));
  }
}

Future _getHeader() async {
  return {
    'sandbox-key': sandboxKey,
    'Authorization': 'dskjdks',
    'Content-Type': 'application/json'
  };
}
