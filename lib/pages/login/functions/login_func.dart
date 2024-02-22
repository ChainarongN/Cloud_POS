import 'dart:convert';

import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFunc {
  LoginFunc._internal();
  static final LoginFunc _instance = LoginFunc._internal();
  factory LoginFunc() => _instance;

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
}
