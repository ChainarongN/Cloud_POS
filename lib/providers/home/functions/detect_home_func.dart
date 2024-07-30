import 'dart:convert';

import 'package:cloud_pos/models/hold_bill_search_model.dart';
import 'package:cloud_pos/models/open_tran_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectHomeFunc {
  DetectHomeFunc._internal();
  static final DetectHomeFunc _instance = DetectHomeFunc._internal();
  factory DetectHomeFunc() => _instance;

  Future<HoldBillSearchModel> detectHoldBillSearch(
      BuildContext context, var response) async {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    HoldBillSearchModel? holdBillSearchModel;
    try {
      if (response is Failure) {
        homeProvider.apisState = ApiState.ERROR;
        DialogStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/homePage');
        Constants().printCheckError(response.errorResponse, 'holdBillSearch');
      } else {
        holdBillSearchModel =
            HoldBillSearchModel.fromJson(jsonDecode(response));
        if (holdBillSearchModel.responseCode!.isEmpty) {
          homeProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'holdBillSearch');
        } else {
          homeProvider.apisState = ApiState.ERROR;
          DialogStyle().dialogError(context,
              error: holdBillSearchModel.responseText!,
              isPopUntil: true,
              popToPage: '/homePage');
          Constants().printCheckError(
              holdBillSearchModel.responseText, 'holdBillSearch');
        }
      }
    } catch (e, strack) {
      homeProvider.apisState = ApiState.ERROR;
      Constants().printError(strack.toString());
      DialogStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/homePage');
      Constants().printCheckError('$e - $strack', 'holdBillSearch');
    }
    return holdBillSearchModel!;
  }

  Future<OpenTranModel> detectOpenTran(
      BuildContext context, var response) async {
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    OpenTranModel? openTranModel;
    try {
      if (response is Failure) {
        homeProvider.apisState = ApiState.ERROR;
        DialogStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/homePage');
        Constants().printCheckError(response.errorResponse, 'OpenTransaction');
      } else {
        openTranModel = OpenTranModel.fromJson(jsonDecode(response));
        if (openTranModel.responseCode!.isEmpty) {
          homeProvider.apisState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'OpenTransaction');
        } else {
          homeProvider.apisState = ApiState.ERROR;
          DialogStyle().dialogError(context,
              error: openTranModel.responseText!,
              isPopUntil: true,
              popToPage: '/homePage');
          Constants()
              .printCheckError(openTranModel.responseText!, 'OpenTransaction');
        }
      }
    } catch (e, strack) {
      homeProvider.apisState = ApiState.ERROR;
      Constants().printCheckError('$e - $strack', 'OpenTransaction');
      DialogStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/homePage');
    }
    return openTranModel!;
  }
}
