import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Column showOrderFromCoupon(
    MenuProvider dataProvider, int index, BuildContext context) {
  return Column(
    children: [
      Card(
        child: Padding(
          padding: EdgeInsets.all(Constants().screenWidth(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.product_name.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .orderList![index].itemName!,
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.qty.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider
                          .transactionModel!.responseObj!.orderList![index].qty!
                          .toInt()
                          .toString(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.price.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .orderList![index].unitPrice!
                          .toString(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.total_price.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .orderList![index].retailPrice!
                          .toString(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.disc_qty.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .orderList![index].promoItemList!.length
                          .toString(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.promo_disc.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.sumTotalDiscountCoupon(index, 'totalDis'),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('${LocaleKeys.sales_prices.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.sumTotalDiscountCoupon(index, 'salesPrice'),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold(
                      '${LocaleKeys.promotion_name.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .orderList![index].promoItemList!
                          .map((item) => item.promotionName)
                          .toList()
                          .join(", "),
                      size: Constants().screenWidth(context) *
                          Constants.normalSizeMB),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
            ],
          ),
        ),
      ),
    ],
  );
}
