import 'dart:convert';

import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/models/open_session_model.dart';
import 'package:cloud_pos/models/start_process_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectLoginFunc {
  DetectLoginFunc._internal();
  static final DetectLoginFunc _instance = DetectLoginFunc._internal();
  factory DetectLoginFunc() => _instance;

  Future<AuthTokenModel> detectAuthToken(
      BuildContext context, var response) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    AuthTokenModel? authTokenModel;
    try {
      if (response is Failure) {
        loginProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/loginPage');
      } else {
        authTokenModel = AuthTokenModel.fromJson(jsonDecode(response));
        loginProvider.apisState = ApiState.COMPLETED;
        Constants().printCheckFlow(response, 'auth token');
      }
    } catch (e, strack) {
      loginProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      await LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/loginPage');
    }
    return authTokenModel!;
  }

  Future<CoreInitModel> detectCoreDataInit(
      BuildContext context, var response) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    CoreInitModel? coreInitModel;
    try {
      if (response is Failure) {
        loginProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/loginPage');
      } else {
        coreInitModel = CoreInitModel.fromJson(jsonDecode(response));
        if (coreInitModel.responseCode!.isEmpty) {
          loginProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'CoreDataInit');
        } else {
          loginProvider.apisState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: coreInitModel.responseText!,
              isPopUntil: true,
              popToPage: '/loginPage');
        }
      }
    } catch (e, strack) {
      loginProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/loginPage');
    }
    return coreInitModel!;
  }

  Future<LoginModel> detectLogin(BuildContext context, var response) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    LoginModel? loginModel;
    try {
      if (response is Failure) {
        loginProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/loginPage');
      } else {
        
        loginModel = LoginModel.fromJson(jsonDecode(response));
        loginProvider.apisState = ApiState.COMPLETED;
      }
    } catch (e, strack) {
      loginProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/loginPage');
    }
    return loginModel!;
  }

  Future<OpenSessionModel> detectOpenSession(
      BuildContext context, var response) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    OpenSessionModel? openSessionModel;
    try {
      if (response is Failure) {
        loginProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/loginPage');
      } else {
        openSessionModel = OpenSessionModel.fromJson(jsonDecode(response));
        if (openSessionModel.responseCode!.isEmpty) {
          loginProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'openSession');
        } else {
          loginProvider.apisState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: openSessionModel.responseText!,
              isPopUntil: true,
              popToPage: '/loginPage');
        }
      }
    } catch (e, strack) {
      loginProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/loginPage');
    }
    return openSessionModel!;
  }

  Future<StartProcessModel> detectStartProcess(
      BuildContext context, var response) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    StartProcessModel? startProcessModel;
    try {
      if (response is Failure) {
        loginProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/loginPage');
      } else {
        startProcessModel = StartProcessModel.fromJson(jsonDecode(response));
        if (startProcessModel.responseCode!.isEmpty) {
          loginProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'startProcess');
        } else {
          loginProvider.apisState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: startProcessModel.responseText!,
              isPopUntil: true,
              popToPage: '/loginPage');
        }
      }
    } catch (e, strack) {
      loginProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/loginPage');
    }
    return startProcessModel!;
  }
}
