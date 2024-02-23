// ignore_for_file: use_build_context_synchronously
import 'package:cloud_pos/providers/provider.dart';
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
}
