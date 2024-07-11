import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container merchantDetailTablet(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  return Container(
    margin: EdgeInsets.only(left: Constants().screenheight(context) * 0.03),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.11,
              child: AppTextStyle().textBold(
                  '${LocaleKeys.merchant_name.tr()} : ',
                  size: Constants().screenheight(context) * 0.023),
            ),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.023)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.2,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.merchantName!,
                        size: Constants().screenheight(context) * 0.023),
                  )
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.11,
              child: AppTextStyle().textBold('${LocaleKeys.brand_name.tr()} : ',
                  size: Constants().screenheight(context) * 0.023),
            ),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.023)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.2,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.brandName!,
                        size: Constants().screenheight(context) * 0.023),
                  )
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.11,
              child: AppTextStyle().textBold('${LocaleKeys.shop_name.tr()} : ',
                  size: Constants().screenheight(context) * 0.023),
            ),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.023)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.2,
                    child: AppTextStyle().textNormal(
                        loginWatch.shopData!.shopName!,
                        size: Constants().screenheight(context) * 0.023),
                  )
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.11,
              child: AppTextStyle().textBold('${LocaleKeys.pos_name.tr()} : ',
                  size: Constants().screenheight(context) * 0.023),
            ),
            loginWatch.shopData == null
                ? AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.023)
                : SizedBox(
                    width: Constants().screenWidth(context) * 0.2,
                    child: AppTextStyle().textNormal('-',
                        size: Constants().screenheight(context) * 0.023),
                  )
          ],
        ),
      ],
    ),
  );
}
