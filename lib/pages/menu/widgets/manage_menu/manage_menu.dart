import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

Card manageMenu(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Card(
    child: Container(
      color: Colors.white,
      width: Constants().screenWidth(context) * 0.33,
      height: Constants().screenheight(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              orderTitle(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderList(menuWatch, menuRead, context),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderDetail(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              couponList(context, menuRead, menuWatch),
              binButton(context, menuWatch, menuRead),
              priceList(context, menuRead)
            ],
          ),
        ),
      ),
    ),
  );
}

Row priceList(BuildContext context, MenuProvider menuRead) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '50');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('50',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '100');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('100',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '500');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('500',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '1000');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('1000',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Row binButton(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
        onTap: () async {
          if (menuWatch.productAddModel == null ||
              menuWatch.productAddModel!.responseCode!.isNotEmpty ||
              menuWatch.productAddModel!.responseObj!.orderList!.isEmpty) {
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
        child: Container(
          width: Constants().screenWidth(context) * 0.15,
          height: Constants().screenheight(context) * 0.08,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0018),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Constants.primaryColor),
            color: Colors.blue.shade800,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.receipt_long,
                    color: Colors.white,
                    size: Constants().screenheight(context) * 0.055),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.setTabToPayment(5);
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.15,
          height: Constants().screenheight(context) * 0.085,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0018),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Constants.primaryColor),
            color: Colors.blue.shade800,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.local_printshop_rounded,
                    color: Colors.white,
                    size: Constants().screenheight(context) * 0.055),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Row couponList(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          LoadingStyle().dialogLoadding(context);
          menuRead.orderSummary(context).then((value) {
            if (menuWatch.apiState == ApiState.COMPLETED) {
              Navigator.maybePop(context).then((value) {
                eCouponDialog(context);
              });
            }
          });
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.09,
          height: Constants().screenheight(context) * 0.084,
          padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Constants.primaryColor),
            color: Constants.secondaryColor,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.local_attraction,
                    color: Colors.black54,
                    size: Constants().screenheight(context) * 0.03),
                AppTextStyle().textNormal('e-Coupon'),
              ],
            ),
          ),
        ),
      ),
      Container(
        width: Constants().screenWidth(context) * 0.09,
        height: Constants().screenheight(context) * 0.084,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Constants.secondaryColor,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.percent,
                  color: Colors.black54,
                  size: Constants().screenheight(context) * 0.028),
              AppTextStyle().textNormal(LocaleKeys.discount_other.tr()),
            ],
          ),
        ),
      ),
      Container(
        width: Constants().screenWidth(context) * 0.09,
        height: Constants().screenheight(context) * 0.084,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Constants.secondaryColor,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.discount,
                  color: Colors.black54,
                  size: Constants().screenheight(context) * 0.028),
              AppTextStyle().textNormal(LocaleKeys.discount.tr()),
            ],
          ),
        ),
      ),
    ],
  );
}

Row orderDetail(BuildContext context, MenuProvider menuWatch) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: Constants().screenWidth(context) * 0.15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.total_qty.tr()}:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.totalQty!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.total_discount.tr()}:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.totalDiscount!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.service_charge.tr()}:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.serviceCharge!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.other_income.tr()}:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.tax.tr()} 7.00%:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.vATPercent!
                        .toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin:
            EdgeInsets.only(left: Constants().screenheight(context) * 0.017),
        width: Constants().screenWidth(context) * 0.15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.sub_total.tr()}:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.grand_total.tr()}:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Rounding:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.roundingBill!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.pay_amount.tr()}:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.payAmount!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Before Tex:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

SizedBox orderList(
    MenuProvider menuWatch, MenuProvider menuRead, BuildContext context) {
  return menuWatch.productAddModel == null ||
          menuWatch.productAddModel!.responseCode!.isNotEmpty ||
          menuWatch.productAddModel!.responseObj!.orderList!.isEmpty
      ? SizedBox(
          height: Constants().screenheight(context) * 0.3,
          child: Center(
              child:
                  AppTextStyle().textNormal(LocaleKeys.there_is_no_menu.tr())),
        )
      : SizedBox(
          height: Constants().screenheight(context) * 0.3,
          child: ListView(
            children: [
              Column(
                children: List.generate(
                  menuWatch.productAddModel!.responseObj!.orderList!.length,
                  (index) => Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: AppTextStyle().textNormal(menuWatch
                                        .productAddModel!
                                        .responseObj!
                                        .orderList![index]
                                        .itemName!),
                                    content: TextField(
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          hintText: LocaleKeys.input_your_remark
                                              .tr()),
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textNormal(
                                            LocaleKeys.cancel.tr(),
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                          width: Constants()
                                                  .screenheight(context) *
                                              0.025),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.ok.tr(),
                                            color: Constants.primaryColor),
                                      ),
                                    ],
                                  );
                                });
                          },
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: LocaleKeys.remark.tr(),
                        ),
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) {},
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: LocaleKeys.delete.tr(),
                        ),
                      ],
                    ),
                    child: Container(
                      height: Constants().screenheight(context) * 0.065,
                      margin: EdgeInsets.only(
                          bottom: Constants().screenheight(context) * 0.01,
                          right: Constants().screenheight(context) * 0.01),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () =>
                                menuRead.removeCountOrder(context, index),
                            child: Icon(Icons.remove_circle_outline,
                                color: Colors.red,
                                size:
                                    Constants().screenheight(context) * 0.045),
                          ),
                          GestureDetector(
                            onTap: () {
                              menuRead.clearReasonText();
                              openQtyDialog(
                                  context, menuWatch, menuRead, index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Constants().screenWidth(context) * 0.03,
                              child: AppTextStyle().textBold(
                                  menuWatch.productAddModel!.responseObj!
                                      .orderList![index].qty
                                      .toString()
                                      .split(
                                          '.') //Why split ? because int.parse is Invalid radix-10 number. i don't know why
                                      .first,
                                  size:
                                      Constants().screenheight(context) * 0.02),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => menuRead.addCountOrder(context, index),
                            child: Icon(Icons.add_box_outlined,
                                color: Constants.primaryColor,
                                size:
                                    Constants().screenheight(context) * 0.045),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      Constants().screenheight(context) * 0.01),
                              width: Constants().screenWidth(context) * 0.155,
                              child: AppTextStyle().textBold(
                                  menuWatch.productAddModel!.responseObj!
                                      .orderList![index].itemName!,
                                  size: Constants().screenheight(context) *
                                      0.023)),
                          const Spacer(),
                          Container(
                              alignment: Alignment.centerRight,
                              width: Constants().screenWidth(context) * 0.06,
                              child: AppTextStyle().textBold(
                                  menuWatch.productAddModel!.responseObj!
                                      .orderList![index].retailPrice!
                                      .toString(),
                                  size: Constants().screenheight(context) *
                                      0.023)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

Row orderTitle(BuildContext context, MenuProvider menuWatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        child: AppTextStyle().textBold(menuWatch.getSaleModeName,
            size: Constants().screenheight(context) * 0.027),
      ),
      Container(
        child: menuWatch.productAddModel != null &&
                menuWatch.productAddModel!.responseCode!.isEmpty
            ? AppTextStyle().textBold(menuWatch.getDueAmountCurrent,
                size: Constants().screenheight(context) * 0.027)
            : AppTextStyle().textBold('0.00',
                size: Constants().screenheight(context) * 0.027),
      )
    ],
  );
}

openQtyDialog(BuildContext context, MenuProvider menuWatch,
    MenuProvider menuRead, int index) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.15,
          child: Column(
            children: <Widget>[
              Container(
                width: Constants().screenWidth(context) * 0.2,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: menuWatch.getvalueQtyOrderController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: '${LocaleKeys.enter_your_qty.tr()}.',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.027),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenheight(context) * 0.025),
            onPressed: () {
              menuRead.dialogCountOrder(context, index);
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenheight(context) * 0.025,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context, false);
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
                          controller: menuWatch.getScreenshotController,
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
                              menuWatch.getScreenshotController
                                  .capture(
                                      delay: const Duration(seconds: 1),
                                      pixelRatio: 1.3)
                                  .then((Uint8List? value) async {
                                await Printer().printer(value!).then((value) {
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

Future<dynamic> eCouponInquiryDialog(
    BuildContext context, MenuProvider menuPvd) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: Constants().screenheight(context) * 0.02),
                        child: Icon(Icons.local_attraction,
                            size: Constants().screenheight(context) * 0.06),
                      ),
                      AppTextStyle().textNormal('Voucher Information',
                          size: Constants().screenheight(context) * 0.03),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01,
                        bottom: Constants().screenheight(context) * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenheight(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold('Voucher ID',
                                    size: Constants().screenheight(context) *
                                        0.024),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .voucherID
                                        .toString(),
                                    size: Constants().screenheight(context) *
                                        0.024)
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenheight(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold('Coupon System',
                                    size: Constants().screenheight(context) *
                                        0.024),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .couponSystem!,
                                    size: Constants().screenheight(context) *
                                        0.023)
                              ],
                            ),
                          ),
                        ),
                        ClipOval(
                            child: SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          height: Constants().screenheight(context) * 0.12,
                          child: Image.network(
                            menuPvd.couponInquiryModel!.responseObj!.imageUrl!,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Constants().screenheight(context) * 0.012,
                          bottom: Constants().screenheight(context) * 0.012,
                          left: Constants().screenheight(context) * 0.035,
                          right: Constants().screenheight(context) * 0.035),
                      child: Column(
                        children: <Widget>[
                          AppTextStyle().textBold('Voucher Status',
                              size: Constants().screenheight(context) * 0.024),
                          AppTextStyle().textNormal(
                              menuPvd
                                  .couponInquiryModel!.responseObj!.resultText!,
                              size: Constants().screenheight(context) * 0.024,
                              color: menuPvd.couponInquiryModel!.responseObj!
                                          .voucherStatus ==
                                      1
                                  ? Colors.green
                                  : Colors.red)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.018),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Voucher S/N : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.voucherSN!
                                    .isNotEmpty
                                ? menuPvd
                                    .couponInquiryModel!.responseObj!.voucherSN!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Voucher Name : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Promotion Code : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Promotion Name : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Voucher Amount : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Voucher Value : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold('Expire Date : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.expireDate!
                                    .isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .expireDate!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: AppTextStyle().textNormal('Apply',
                  size: Constants().screenheight(context) * 0.03,
                  color:
                      menuPvd.couponInquiryModel!.responseObj!.voucherStatus !=
                              1
                          ? Colors.grey.shade400
                          : Colors.blueAccent),
              onPressed: () async {
                if (menuPvd.couponInquiryModel!.responseObj!.voucherStatus ==
                    1) {
                  LoadingStyle().dialogLoadding(context);
                  menuPvd.eCouponApply(context).then((value) {
                    if (menuPvd.apiState == ApiState.COMPLETED) {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    }
                  });
                }
              },
            ),
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.close.tr(),
                  size: Constants().screenheight(context) * 0.03,
                  color: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Future<void> eCouponDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Consumer<MenuProvider>(
      builder: (context, dataProvider, child) => AlertDialog(
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: Constants().screenheight(context) * 0.02),
              child: Icon(Icons.local_attraction,
                  size: Constants().screenheight(context) * 0.065),
            ),
            AppTextStyle().textNormal('Coupon / Promotion',
                size: Constants().screenheight(context) * 0.03),
            const Spacer(),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: Constants().screenWidth(context) * 0.3,
                  child: TextField(
                    controller: dataProvider.getcouponCodeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      labelText: 'รหัสบัตร',
                      border: Constants().myinputborder(), //normal border
                      enabledBorder:
                          Constants().myinputborder(), //enabled border
                      focusedBorder:
                          Constants().myfocusborder(), //focused border
                    ),
                    style: TextStyle(
                        color: Constants.textColor,
                        fontSize: Constants().screenheight(context) * 0.024),
                  ),
                ),
                SizedBox(
                  width: Constants().screenWidth(context) * 0.1,
                  height: Constants().screenheight(context) * 0.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 157, 198, 255),
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        LoadingStyle().dialogLoadding(context);
                        dataProvider.eCouponInquiry(context).then((value) {
                          if (dataProvider.apiState == ApiState.COMPLETED) {
                            Navigator.maybePop(context).then((value) {
                              eCouponInquiryDialog(context, dataProvider);
                            });
                          }
                        });
                      },
                      child: AppTextStyle().textBold('OK',
                          size: Constants().screenheight(context) * 0.034,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
        content: SizedBox(
            width: Constants().screenWidth(context),
            height: Constants().screenheight(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('No.',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold(
                                      'หมายเลขบัตรกำนัล',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold(
                                      'ชื่อโปรโมชั่น',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('ลบ',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Constants().screenheight(context) * 0.16,
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  dataProvider.orderSummaryModel!.responseObj!
                                      .promoList!.length,
                                  (index) => Column(
                                    children: [
                                      const Divider(thickness: 0.3),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: AppTextStyle().textNormal(
                                                  '${index + 1}',
                                                  size: Constants()
                                                          .screenheight(
                                                              context) *
                                                      0.024),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: AppTextStyle().textNormal(
                                                  dataProvider
                                                      .orderSummaryModel!
                                                      .responseObj!
                                                      .promoList![index]
                                                      .couponList!
                                                      .first
                                                      .couponNumber!,
                                                  size: Constants()
                                                          .screenheight(
                                                              context) *
                                                      0.024),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: AppTextStyle().textNormal(
                                                  dataProvider
                                                      .orderSummaryModel!
                                                      .responseObj!
                                                      .promoList![index]
                                                      .promotionName!,
                                                  size: Constants()
                                                          .screenheight(
                                                              context) *
                                                      0.024),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  LoadingStyle()
                                                      .dialogLoadding(context);
                                                  dataProvider
                                                      .promotionCancel(
                                                          context, index)
                                                      .then((value) {
                                                    if (dataProvider.apiState ==
                                                        ApiState.COMPLETED) {
                                                      Navigator.maybePop(
                                                          context);
                                                    }
                                                  });
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Colors.red,
                                                    size: Constants()
                                                            .screenheight(
                                                                context) *
                                                        0.045),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              // Expanded(
                              //   flex: 1,
                              //   child: Center(
                              //     child: AppTextStyle().textBold('No.',
                              //         size: Constants().screenheight(context) *
                              //             0.024),
                              //   ),
                              // ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: AppTextStyle().textBold('Product Name',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('Qty',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Total Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('Disc Qty',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Promo Disc',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Sales Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: AppTextStyle().textBold(
                                      'Promotion Name',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Constants().screenheight(context) * 0.3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  dataProvider.orderSummaryModel!.responseObj!
                                      .orderList!.length,
                                  (index) => dataProvider
                                          .orderSummaryModel!
                                          .responseObj!
                                          .orderList![index]
                                          .promoItemList!
                                          .isNotEmpty
                                      ? Column(
                                          children: [
                                            const Divider(thickness: 0.3),
                                            Row(
                                              children: <Widget>[
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Center(
                                                //     child: AppTextStyle()
                                                //         .textNormal(
                                                //             '${index + 1}',
                                                //             size: Constants()
                                                //                     .screenheight(
                                                //                         context) *
                                                //                 0.024),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .itemName!,
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .qty
                                                            .toString(),
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .unitPrice
                                                            .toString(),
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .retailPrice
                                                            .toString(),
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .promoItemList!
                                                            .length
                                                            .toString(),
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        dataProvider
                                                            .orderSummaryModel!
                                                            .responseObj!
                                                            .orderList![index]
                                                            .promoItemList!
                                                            .first
                                                            .totalDiscount
                                                            .toString(),
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        '${double.parse(dataProvider.orderSummaryModel!.responseObj!.orderList![index].retailPrice.toString()) - dataProvider.orderSummaryModel!.responseObj!.orderList![index].promoItemList!.first.totalDiscount!}',
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                    child: AppTextStyle().textNormal(
                                                        '${dataProvider.orderSummaryModel!.responseObj!.orderList![index].promoItemList!.first.promotionName} (${dataProvider.getWhereCouponId(dataProvider.orderSummaryModel!.responseObj!.orderList![index].promoItemList!.first.promotionID!)})',
                                                        size: Constants()
                                                                .screenheight(
                                                                    context) *
                                                            0.024),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
        actions: <Widget>[
          // TextButton(
          //   child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
          //       size: Constants().screenheight(context) * 0.03),
          //   onPressed: () async {},
          // ),
          TextButton(
            child: AppTextStyle().textNormal(
              LocaleKeys.close.tr(),
              size: Constants().screenheight(context) * 0.03,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
