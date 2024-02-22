import 'dart:convert';

import 'package:cloud_pos/models/open_session_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenSessionFunc {
  OpenSessionFunc._internal();
  static final OpenSessionFunc _instance = OpenSessionFunc._internal();
  factory OpenSessionFunc() => _instance;

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
}
