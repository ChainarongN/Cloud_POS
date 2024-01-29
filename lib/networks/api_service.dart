// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:cloud_pos/utils/constants.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class APIService {
  APIService._internal();
  static final APIService _instance = APIService._internal();
  factory APIService() => _instance;

  Future postParams({String? url, String? token, var data}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();

    try {
      var response = await dio.request(
        url!,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        queryParameters: data,
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        return json.encode(response.data);
      }
      return Failure(
        code: response.statusCode!,
        errorResponse: response.data,
      );
    } catch (e) {
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }

  Future post(String url, var data) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var dio = Dio();
    try {
      var response = await dio.request(
        url,
        options: Options(method: 'POST', headers: headers),
        data: data,
      );
      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        return json.encode(response.data);
      }
      return Failure(
        code: response.statusCode!,
        errorResponse: response.data,
      );
    } catch (e) {
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }
}

class Failure {
  int code;
  Object errorResponse;
  Failure({required this.code, required this.errorResponse});
}

enum ApiState { LOADING, COMPLETED, ERROR }
