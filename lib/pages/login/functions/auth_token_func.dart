import 'dart:convert';

import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthTokenFunc {
  AuthTokenFunc._internal();
  static final AuthTokenFunc _instance = AuthTokenFunc._internal();
  factory AuthTokenFunc() => _instance;

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
}
