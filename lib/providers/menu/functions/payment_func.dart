// ignore_for_file: use_build_context_synchronously

import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentFunc {
  PaymentFunc._internal();
  static final PaymentFunc _instance = PaymentFunc._internal();
  factory PaymentFunc() => _instance;

  Future paymentSubmitFlow(
      {BuildContext? context,
      String? payAmount,
      String? payCode,
      String? payName,
      int? payTypeId,
      String? payRemark,
      bool? fromQuick}) async {
    var menuProvider = Provider.of<MenuProvider>(context!, listen: false);
    if (menuProvider.transactionModel!.responseObj!.orderList!.isEmpty) {
      return;
    } else {
      if (fromQuick!) {
        if (double.parse(payAmount!) <
            menuProvider.transactionModel!.responseObj!.dueAmount!) {
          await DialogStyle().dialogError(context,
              error:
                  'You pay $payAmount THB.  ${LocaleKeys.pay_amount_must_more_than_total_price.tr()}',
              isPopUntil: false);
        } else {
          await DialogStyle().confirmDialog2(
            context!,
            title: 'Payment',
            detail: 'You need to pay $payAmount THB. ?',
            onPressed: () async {
              DialogStyle().dialogLoadding(context);
              await menuProvider.paymentSubmit(context,
                  payAmount: payAmount,
                  payCode: payCode,
                  payName: payName,
                  payTypeId: payTypeId,
                  payRemark: payRemark);
              await menuProvider.finalizeBill(context);
            },
          );
        }
      } else {
        DialogStyle().dialogLoadding(context);
        await menuProvider.paymentSubmit(context,
            payAmount: payAmount,
            payCode: payCode,
            payName: payName,
            payTypeId: payTypeId,
            payRemark: payRemark);
        Navigator.maybePop(context);
        if (menuProvider.transactionModel!.responseObj!.tranData!.dueAmount! ==
                0 ||
            menuProvider.transactionModel!.responseObj!.tranData!.dueAmount! ==
                0.0) {
          await menuProvider.finalizeBill(context);
        }
      }
    }
  }
}
