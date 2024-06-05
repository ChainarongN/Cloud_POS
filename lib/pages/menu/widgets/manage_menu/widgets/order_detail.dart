import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.totalQty!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.total_discount.tr()}:'),
                const Spacer(),
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.totalDiscount!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.service_charge.tr()}:'),
                const Spacer(),
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.serviceCharge!
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
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.vATPercent!
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
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.roundingBill!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('${LocaleKeys.pay_amount.tr()}:'),
                const Spacer(),
                menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .transactionModel!.responseObj!.payAmount!
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
