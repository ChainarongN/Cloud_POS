import 'dart:convert';

import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoreDataInitFunc {
  CoreDataInitFunc._internal();
  static final CoreDataInitFunc _instance = CoreDataInitFunc._internal();
  factory CoreDataInitFunc() => _instance;

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
}
