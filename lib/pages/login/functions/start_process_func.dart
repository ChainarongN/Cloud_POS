import 'dart:convert';

import 'package:cloud_pos/models/start_process_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartProcessFunc {
  StartProcessFunc._internal();
  static final StartProcessFunc _instance = StartProcessFunc._internal();
  factory StartProcessFunc() => _instance;

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
