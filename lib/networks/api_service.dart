// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/service/firebase_log.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class APIService {
  APIService._internal();
  static final APIService _instance = APIService._internal();
  factory APIService() => _instance;

  Future postAndData(
      {String? url,
      String? token,
      var param,
      var data,
      String? actionBy}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    BaseOptions options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );

    var dio = Dio(options);
    try {
      var response = await dio.request(url!,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
          queryParameters: param);

      if (response.statusCode == 200) {
        FirebaseLog().logData(true,
            actionBy: actionBy,
            params: param.toString(),
            reqData: data.toString(),
            res: response.data.toString());
        return json.encode(response.data);
      }
      FirebaseLog().logData(false,
          actionBy: actionBy,
          params: param.toString(),
          reqData: data.toString(),
          res: response.data.toString());
      return Failure(
        code: response.statusCode!,
        errorResponse: response.data,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param.toString(),
            reqData: data.toString(),
            res: e.toString());
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param.toString(),
            reqData: data.toString(),
            res: e.toString());
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
    } catch (e) {
      FirebaseLog().logData(false,
          actionBy: actionBy,
          params: param.toString(),
          reqData: data.toString(),
          res: e.toString());
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }

  Future postParams(
      {String? url, String? token, var param, String? actionBy}) async {
    var headers = {'Authorization': 'Bearer $token'};

    BaseOptions options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    var dio = Dio(options);

    try {
      var response = await dio.request(
        url!,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        queryParameters: param,
      );

      if (response.statusCode == 200) {
        FirebaseLog().logData(true,
            actionBy: actionBy,
            params: param.toString(),
            res: response.data.toString());
        return json.encode(response.data);
      }
      FirebaseLog().logData(false,
          actionBy: actionBy,
          params: param.toString(),
          res: response.data.toString());
      return Failure(
        code: response.statusCode!,
        errorResponse: response.data,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy, params: param.toString(), res: e.toString());
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy, params: param.toString(), res: e.toString());
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
    } catch (e) {
      FirebaseLog().logData(false,
          actionBy: actionBy, params: param.toString(), res: e.toString());
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }

  Future post(String url, var data) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    BaseOptions options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    var dio = Dio(options);
    try {
      var response = await dio.request(
        url,
        options: Options(method: 'POST', headers: headers),
        data: data,
      );
      if (response.statusCode == 200) {
        return json.encode(response.data);
      }

      return Failure(
        code: response.statusCode!,
        errorResponse: response.data,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
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
