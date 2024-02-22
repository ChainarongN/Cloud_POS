// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_pos/models/payment_submit_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentFunc {
  PaymentFunc._internal();
  static final PaymentFunc _instance = PaymentFunc._internal();
  factory PaymentFunc() => _instance;

  Future<void> paymentCashType(
      {BuildContext? context, String? payAmount}) async {
    var menuProvider = Provider.of<MenuProvider>(context!, listen: false);
    await LoadingStyle().confirmDialog2(
      context,
      title: 'Payment',
      detail: 'You need to pay $payAmount THB. ?',
      onPressed: () async {
        LoadingStyle().dialogLoadding(context);
        await menuProvider.paymentSubmit(
          context,
          payAmount: payAmount,
          payCode: 'CS',
          payName: 'Cash',
          payTypeId: 1,
        );
        await menuProvider.finalizeBill(context);
      },
    );
  }

  Future<PaymentSubmitModel> detectPaymentSubmit(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    PaymentSubmitModel? paymentSubmitModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        paymentSubmitModel = PaymentSubmitModel.fromJson(jsonDecode(response));
        if (paymentSubmitModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'paymentSubmit');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: paymentSubmitModel.responseText,
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

    return paymentSubmitModel!;
  }
}
