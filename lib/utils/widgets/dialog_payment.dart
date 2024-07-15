import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogPayment {
  DialogPayment._internal();
  static final DialogPayment _instance = DialogPayment._internal();
  factory DialogPayment() => _instance;

  Future<void> dialogCredit(BuildContext context,
      {int? payTypeId,
      String? payTypeName,
      String? payTypeCode,
      MenuProvider? menuRead,
      MenuProvider? menuWatch}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        menuWatch!.dueAmountController.text =
            menuWatch.transactionModel!.responseObj!.dueAmount.toString();
        return Dialog(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.android, size: 35),
                      SizedBox(width: Constants().screenWidth(context) * 0.02),
                      AppTextStyle().textBold(
                          '${LocaleKeys.payment.tr()} - ${LocaleKeys.credit_card.tr()}.',
                          size: 20)
                    ],
                  ),
                  SizedBox(height: Constants().screenheight(context) * 0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: Constants().screenWidth(context) * 0.11,
                        child: AppTextStyle().textNormal(
                            '${LocaleKeys.total_price.tr()} : ',
                            size: 16),
                      ),
                      SizedBox(width: Constants().screenWidth(context) * 0.008),
                      SizedBox(
                        width: Constants().screenWidth(context) * 0.15,
                        height: Constants().screenheight(context) * 0.05,
                        child: TextField(
                          controller: menuWatch.dueAmountController,
                          readOnly: true,
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(8),
                            suffixText: ' THB.',
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          style: const TextStyle(
                              color: Constants.textColor, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constants().screenheight(context) * 0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: Constants().screenWidth(context) * 0.11,
                        child: AppTextStyle().textNormal(
                            '${LocaleKeys.pay_amount.tr()} : ',
                            size: 16),
                      ),
                      SizedBox(width: Constants().screenWidth(context) * 0.008),
                      Container(
                        width: Constants().screenWidth(context) * 0.15,
                        height: Constants().screenheight(context) * 0.05,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: menuWatch.payAmountCredit,
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                          ],
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            suffixText: ' THB.',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          style: const TextStyle(
                              color: Constants.textColor, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Constants().screenheight(context) * 0.025),
                  SizedBox(
                    width: Constants().screenWidth(context) * 0.26,
                    height: Constants().screenheight(context) * 0.1,
                    child: TextField(
                      controller: menuWatch.paymentRemark,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: LocaleKeys.remark.tr(),
                      ),
                    ),
                  ),
                  SizedBox(height: Constants().screenheight(context) * 0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: Constants().screenWidth(context) * 0.1,
                        child: ElevatedButton(
                          onPressed: () async {
                            double price =
                                double.parse(menuWatch.payAmountCredit.text);
                            if (price >
                                menuWatch.transactionModel!.responseObj!
                                    .dueAmount!) {
                              DialogStyle().dialogError(context,
                                  error: LocaleKeys
                                      .cannot_do_payment_for_amount_more_than_due_amount
                                      .tr(),
                                  isPopUntil: false);
                            } else {
                              await menuRead!
                                  .paymentMulti(
                                      context: context,
                                      payTypeId: payTypeId,
                                      payCode: payTypeCode,
                                      payName: payTypeName,
                                      payRemark: menuWatch.paymentRemark.text,
                                      payAmount: menuWatch.payAmountCredit.text,
                                      fromQuick: false)
                                  .then((value) => Navigator.maybePop(context));
                            }
                          },
                          child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                              color: Colors.green, size: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: Constants().screenWidth(context) * 0.1,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: AppTextStyle().textNormal(
                              LocaleKeys.cancel.tr(),
                              color: Colors.red,
                              size: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
