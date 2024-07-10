import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Column showCouponData(
    MenuProvider dataProvider, int indexOutside, BuildContext context) {
  return Column(
    children: List.generate(
      dataProvider.transactionModel!.responseObj!.promoList![indexOutside]
          .couponList!.length,
      (indexInside) => Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(Constants().screenWidth(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppTextStyle().textBold(
                              '${LocaleKeys.promotion_code.tr()} : ',
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                          AppTextStyle().textNormal(
                              dataProvider
                                  .transactionModel!
                                  .responseObj!
                                  .promoList![indexOutside]
                                  .couponList![indexInside]
                                  .couponNumber!,
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                        ],
                      ),
                      SizedBox(
                          height: Constants().screenheight(context) * 0.005),
                      Row(
                        children: [
                          AppTextStyle().textBold(
                              '${LocaleKeys.promotion_name.tr()} : ',
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                          AppTextStyle().textNormal(
                              dataProvider.transactionModel!.responseObj!
                                  .promoList![indexOutside].promotionName!,
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize)
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      LoadingStyle().dialogLoadding(context);
                      dataProvider
                          .promotionCancel(context, indexOutside, indexInside)
                          .then((value) {
                        if (dataProvider.apiState == ApiState.COMPLETED) {
                          Navigator.maybePop(context);
                        }
                      });
                    },
                    child: Icon(Icons.delete,
                        color: Colors.red,
                        size: Constants().screenWidth(context) * 0.08),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
