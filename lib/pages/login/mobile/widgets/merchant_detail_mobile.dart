import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container merchantDetailMobile(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  return Container(
    margin: EdgeInsets.only(left: Constants().screenheight(context) * 0.03),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.33,
              child: AppTextStyle().textBold(
                  '${LocaleKeys.merchant_name.tr()} : ',
                  size:
                      Constants().screenWidth(context) * Constants.normalSize),
            ),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size:
                        Constants().screenWidth(context) * Constants.normalSize)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.34,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.merchantName!,
                        size: Constants().screenWidth(context) *
                            Constants.normalSize),
                  ),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.33,
                child: AppTextStyle().textBold(
                    '${LocaleKeys.brand_name.tr()} : ',
                    size: Constants().screenWidth(context) *
                        Constants.normalSize)),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size:
                        Constants().screenWidth(context) * Constants.normalSize)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.34,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.brandName!,
                        size: Constants().screenWidth(context) *
                            Constants.normalSize),
                  ),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.33,
                child: AppTextStyle().textBold(
                    '${LocaleKeys.shop_name.tr()} : ',
                    size: Constants().screenWidth(context) *
                        Constants.normalSize)),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size:
                        Constants().screenWidth(context) * Constants.normalSize)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.34,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.shopName!,
                        size: Constants().screenWidth(context) *
                            Constants.normalSize),
                  ),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.33,
                child: AppTextStyle().textBold('${LocaleKeys.pos_name.tr()} : ',
                    size: Constants().screenWidth(context) *
                        Constants.normalSize)),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size:
                        Constants().screenWidth(context) * Constants.normalSize)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.34,
                    child: AppTextStyle().textNormal('-',
                        size: Constants().screenWidth(context) *
                            Constants.normalSize),
                  ),
          ],
        ),
      ],
    ),
  );
}
