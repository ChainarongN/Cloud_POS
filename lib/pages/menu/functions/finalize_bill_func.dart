import 'dart:convert';

import 'package:cloud_pos/models/finalize_bill_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalizeBillFunc {
  FinalizeBillFunc._internal();
  static final FinalizeBillFunc _instance = FinalizeBillFunc._internal();
  factory FinalizeBillFunc() => _instance;

  Future<FinalizeBillModel> detectOrderSummary(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    FinalizeBillModel? finalizeBillModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        finalizeBillModel = FinalizeBillModel.fromJson(jsonDecode(response));
        if (finalizeBillModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'finalizeBill');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: finalizeBillModel.responseText,
              isPopUntil: true,
              popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }

    return finalizeBillModel!;
  }
}
