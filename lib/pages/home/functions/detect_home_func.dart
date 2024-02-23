import 'dart:convert';

import 'package:cloud_pos/models/open_tran_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectHomeFunc {
  DetectHomeFunc._internal();
  static final DetectHomeFunc _instance = DetectHomeFunc._internal();
  factory DetectHomeFunc() => _instance;

  Future<OpenTranModel> detectOpenTran(
      BuildContext context, var response) async {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    OpenTranModel? openTranModel;
    try {
      if (response is Failure) {
        homeProvider.apisState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/homePage');
      } else {
        openTranModel = OpenTranModel.fromJson(jsonDecode(response));
        if (openTranModel.responseCode!.isEmpty) {
          homeProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'OpenTransaction');
        } else {
          homeProvider.apisState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: openTranModel.responseText!,
              isPopUntil: true,
              popToPage: '/homePage');
        }
      }
    } catch (e, strack) {
      homeProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/homePage');
    }
    return openTranModel!;
  }
}
