// ignore_for_file: use_build_context_synchronously

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentFunc {
  PaymentFunc._internal();
  static final PaymentFunc _instance = PaymentFunc._internal();
  factory PaymentFunc() => _instance;

  Future<bool> payment({BuildContext? context, String? payAmount}) async {
    var menuProvider = Provider.of<MenuProvider>(context!, listen: false);
    bool isSuccess = false;
    await LoadingStyle().confirmDialog2(
      context,
      title: 'Payment',
      detail: 'You need to pay $payAmount THB. ?',
      onPressed: () async {
        LoadingStyle().dialogLoadding(context);
        await menuProvider.paymentSubmit(context, payAmount: payAmount);
        await menuProvider.finalizeBill(context);
        if (menuProvider.apiState == ApiState.COMPLETED) {
          isSuccess = true;
          await LoadingStyle().dialogPayment2(context,
              text: menuProvider
                  .paymentSubmitModel!.responseObj!.paymentList!.last.cashChange
                  .toString(),
              popUntil: true,
              popToPage: '/homePage');
        }
      },
    );
    return isSuccess;
  }
}
