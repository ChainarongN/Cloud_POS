import 'dart:typed_data';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:screenshot/screenshot.dart';

Row priceListTablet(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '100');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.07,
          height: Constants().screenheight(context) * 0.06,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.red.shade400,
            boxShadow: const [
              BoxShadow(color: Colors.red, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: AppTextStyle().textBold('100',
                size: Constants().screenheight(context) * 0.035),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '500');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.07,
          height: Constants().screenheight(context) * 0.06,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.purple.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.purple, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: AppTextStyle().textBold('500',
                size: Constants().screenheight(context) * 0.035),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '1000');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.07,
          height: Constants().screenheight(context) * 0.06,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: AppTextStyle().textBold('1000',
                size: Constants().screenheight(context) * 0.035),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // menuRead.paymentCash(context: context, payAmount: '50');
          moreChoiceDialog(context, menuRead, menuWatch);
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.07,
          height: Constants().screenheight(context) * 0.06,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Constants.primaryColor,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: const Center(
            child: Icon(Icons.more_horiz),
          ),
        ),
      ),
    ],
  );
}

Future<void> moreChoiceDialog(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.65,
          width: Constants().screenWidth(context) * 0.3,
          child: Padding(
            padding: EdgeInsets.all(Constants().screenWidth(context) * 0.01),
            child: ListView(padding: EdgeInsets.zero, children: [
              GestureDetector(
                onTap: () {
                  menuRead.paymentCash(
                      context: context,
                      payAmount: menuWatch
                          .transactionModel!.responseObj!.dueAmount
                          .toString());
                },
                child: SizedBox(
                  height: Constants().screenheight(context) * 0.1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      Constants().screenWidth(context) * 0.015,
                                  left:
                                      Constants().screenWidth(context) * 0.015),
                              child: const Icon(Icons.local_printshop_rounded,
                                  color: Constants.primaryColor),
                            ),
                            AppTextStyle().textBold('ชำระด่วน',
                                size: Constants().screenheight(context) * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Constants().screenheight(context) * 0.1,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right: Constants().screenWidth(context) * 0.015,
                                left: Constants().screenWidth(context) * 0.015),
                            child: const Icon(Icons.qr_code,
                                color: Constants.primaryColor),
                          ),
                          AppTextStyle().textBold(
                            'QR Payment',
                            size: Constants().screenheight(context) * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (menuWatch
                      .transactionModel!.responseObj!.orderList!.isEmpty) {
                    LoadingStyle().dialogError(context,
                        error: LocaleKeys.must_have_at_least_1_order.tr(),
                        isPopUntil: true,
                        popToPage: '/menuPage');
                  } else {
                    LoadingStyle().dialogLoadding(context);
                    await menuRead.orderSummary(context).then((value) {
                      if (menuWatch.apiState == ApiState.COMPLETED) {
                        dialogResultHtml(
                            context, menuWatch.getHtmlOrderSummary, menuWatch);
                      }
                    });
                  }
                },
                child: SizedBox(
                  height: Constants().screenheight(context) * 0.1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      Constants().screenWidth(context) * 0.015,
                                  left:
                                      Constants().screenWidth(context) * 0.015),
                              child: const Icon(Icons.receipt_long,
                                  color: Constants.primaryColor),
                            ),
                            AppTextStyle().textBold('Order Sunmary',
                                size: Constants().screenheight(context) * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenWidth(context) * 0.015,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<dynamic> dialogResultHtml(
    BuildContext context, String html, MenuProvider menuWatch) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: Constants().screenWidth(context) * 0.05,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: Constants().screenWidth(context) * 0.29,
                        child: Screenshot(
                          controller: menuWatch.screenshotOrderSumController,
                          child: HtmlWidget(html),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: ContainerStyle2(
                          onPressed: () {
                            if (menuWatch.apiState != ApiState.LOADING) {
                              menuWatch.apiState = ApiState.LOADING;
                              LoadingStyle().dialogLoadding(context);
                              menuWatch.screenshotOrderSumController
                                  .capture(
                                      delay: const Duration(seconds: 1),
                                      pixelRatio: 1.3)
                                  .then((Uint8List? value) async {
                                await Printer()
                                    .printReceipt(value!)
                                    .then((value) {
                                  menuWatch.apiState = ApiState.COMPLETED;
                                  Navigator.of(context).popUntil(
                                      ModalRoute.withName('/menuPage'));
                                });
                              });
                            }
                          },
                          radius: 25,
                          width: Constants().screenWidth(context) * 0.17,
                          height: Constants().screenheight(context) * 0.18,
                          title: LocaleKeys.print_bill.tr(),
                          size: 20,
                          onlyText: false,
                          icon: Icons.add_chart_rounded,
                          shadowColor: Colors.green.shade400,
                          gradient1: Colors.green.shade200,
                          gradient2: Colors.green.shade300,
                          gradient3: Colors.green.shade500,
                          gradient4: Colors.green.shade500,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ContainerStyle2(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/menuPage'));
                          },
                          radius: 25,
                          width: Constants().screenWidth(context) * 0.17,
                          height: Constants().screenheight(context) * 0.18,
                          title: LocaleKeys.close.tr(),
                          size: 20,
                          icon: Icons.close_rounded,
                          onlyText: false,
                          shadowColor: Colors.red.shade400,
                          gradient1: Colors.red.shade200,
                          gradient2: Colors.red.shade300,
                          gradient3: Colors.red.shade500,
                          gradient4: Colors.red.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
