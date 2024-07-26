// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/service/firebase_log.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

class APIService {
  APIService._internal();
  static final APIService _instance = APIService._internal();
  factory APIService() => _instance;

  Future postAndData(BuildContext context,
      {String? url,
      String? token,
      var param,
      var data,
      String? actionBy}) async {
    String baseUrl = await SharedPref().getBaseUrl();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      );
      var dio = Dio(options);
      var response = await dio.request('$baseUrl/$url',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
          queryParameters: param);

      if (response.statusCode == 200) {
        FirebaseLog().logData(true,
            actionBy: actionBy,
            params: param,
            reqData: data,
            res: response.data,
            baseUrl: baseUrl,
            pathUrl: url);
        return json.encode(response.data);
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        String newToken = '';
        await Provider.of<LoginProvider>(context, listen: false)
            .authToken(context);
        newToken = await SharedPref().getToken();
        if (newToken.isNotEmpty) {
          return postAndData(context,
              actionBy: actionBy,
              data: data,
              param: param,
              token: newToken,
              url: url);
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param,
            reqData: data,
            res: e,
            baseUrl: baseUrl,
            pathUrl: url);
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param,
            reqData: data,
            res: e,
            baseUrl: baseUrl,
            pathUrl: url);
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
    } catch (e) {
      FirebaseLog().logData(false,
          actionBy: actionBy,
          params: param,
          reqData: data,
          res: e,
          baseUrl: baseUrl,
          pathUrl: url);
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }

  Future postParams(BuildContext context,
      {String? url, String? token, var param, String? actionBy}) async {
    String baseUrl = await SharedPref().getBaseUrl();
    var headers = {'Authorization': 'Bearer $token'};
    try {
      BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      );
      var dio = Dio(options);
      var response = await dio.request(
        '$baseUrl/$url',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        queryParameters: param,
      );

      if (response.statusCode == 200) {
        FirebaseLog().logData(true,
            actionBy: actionBy,
            params: param,
            reqData: '',
            res: response.data,
            baseUrl: baseUrl,
            pathUrl: url);
        return json.encode(response.data);
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        String newToken = '';
        await Provider.of<LoginProvider>(context, listen: false)
            .authToken(context);
        newToken = await SharedPref().getToken();
        if (newToken.isNotEmpty) {
          return postParams(context,
              actionBy: actionBy, param: param, token: newToken, url: url);
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param,
            res: e,
            reqData: '',
            baseUrl: baseUrl,
            pathUrl: url);
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        FirebaseLog().logData(false,
            actionBy: actionBy,
            params: param,
            res: e,
            baseUrl: baseUrl,
            reqData: '',
            pathUrl: url);
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      }
    } catch (e) {
      FirebaseLog().logData(false,
          actionBy: actionBy,
          params: param,
          reqData: '',
          res: e,
          baseUrl: baseUrl,
          pathUrl: url);
      return Failure(
        code: Constants.UNKNOWN_ERROR,
        errorResponse: '$e',
      );
    }
  }

  Future postToken({String? url, var param, String? actionBy}) async {
    String baseUrl = await SharedPref().getBaseUrl();
    try {
      BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      );
      var dio = Dio(options);

      Constants().printWarning(param.toString());
      Constants().printWarning('$baseUrl/$url');

      var response = await dio.request(
        '$baseUrl/$url',
        options: Options(
          method: 'POST',
        ),
        queryParameters: param,
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type'].toString().contains('text')) {
          return response.data;
        } else {
          return json.encode(response.data);
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Failure(
          code: 408,
          errorResponse: 'Connection Timeout. Check your internet or Try again',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
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
