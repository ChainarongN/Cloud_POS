// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/widgets/dialog_payment.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentFunc {
  PaymentFunc._internal();
  static final PaymentFunc _instance = PaymentFunc._internal();
  factory PaymentFunc() => _instance;

  Future paymentDinamic(BuildContext context,
      {int? payTypeId,
      String? payTypeFlow,
      String? payTypeName,
      String? payTypeCode,
      int? edcType,
      String? payRemark,
      MenuProvider? menuRead,
      MenuProvider? menuWatch}) async {
    menuRead!.clearPaymentField();
    switch (payTypeFlow) {
      case "":
        // dialogCredit(context,
        //     payTypeId: payTypeId,
        //     payTypeName: payTypeName,
        //     payTypeCode: payTypeCode,
        //     menuRead: menuRead,
        //     menuWatch: menuWatch);
        break;
      case "ReqQR":
        DialogStyle().dialogLoadding(context);
        await menuRead
            .paymentQRRequest(context,
                payTypeId: payTypeId,
                edcType: edcType,
                payTypeCode: payTypeCode,
                payTypeName: payTypeName,
                payRemark: '')
            .then((value) {
          if (ApiState.COMPLETED == menuWatch!.apiState) {
            Navigator.maybePop(context);
            DialogPayment().dialogPaymentQR(context,
                menuRead: menuRead,
                menuWatch: menuWatch,
                payRemark: '',
                edcType: edcType,
                payTypeCode: payTypeCode,
                payTypeId: payTypeId,
                payTypeName: payTypeName);
            menuRead.paymentQRInquiry(context,
                payTypeId: payTypeId,
                payTypeCode: payTypeCode,
                payTypeName: payTypeName,
                edcType: edcType,
                payRemark: payRemark,
                isRecursive: true);
          }
        });
        break;
    }
  }

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
            context,
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
