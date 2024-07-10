import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Column showPromotionSum(
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
                  AppTextStyle().textBold(
                      '${LocaleKeys.promotion_name.tr()} : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .promoList![index].promotionName!,
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('Coupon/Voucher No. : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .promoList![index].couponList!
                          .map((item) => item.couponNumber!)
                          .toList()
                          .join(", "),
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                ],
              ),
              SizedBox(height: Constants().screenheight(context) * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle().textBold('Discount Amount : ',
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                  AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .promoList![index].totalDiscount
                          .toString(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
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
