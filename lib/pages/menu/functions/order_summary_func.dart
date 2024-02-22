import 'dart:convert';

import 'package:cloud_pos/models/order_summary_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummaryFunc {
  OrderSummaryFunc._internal();
  static final OrderSummaryFunc _instance = OrderSummaryFunc._internal();
  factory OrderSummaryFunc() => _instance;

  Future<OrderSummaryModel> detectOrderSummary(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    OrderSummaryModel? orderSummaryModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        orderSummaryModel = OrderSummaryModel.fromJson(jsonDecode(response));
        if (orderSummaryModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'orderSummary');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: orderSummaryModel.responseText,
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

    return orderSummaryModel!;
  }
}
