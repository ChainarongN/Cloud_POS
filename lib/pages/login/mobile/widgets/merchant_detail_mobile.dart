import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container merchantDetailMobile(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: Constants().screenheight(context) * 0.03),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: Constants().screenWidth(context) * 0.4,
              child: AppTextStyle().textBold(
                  '${LocaleKeys.merchant_name.tr()} : ',
                  size: Constants().screenWidth(context) * 0.03),
            ),
            AppTextStyle().textNormal('vTec Restaurant',
                size: Constants().screenWidth(context) * 0.03)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.4,
                child: AppTextStyle().textBold(
                    '${LocaleKeys.brand_name.tr()} : ',
                    size: Constants().screenWidth(context) * 0.03)),
            AppTextStyle().textNormal('vTec Brand',
                size: Constants().screenWidth(context) * 0.03)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.4,
                child: AppTextStyle().textBold(
                    '${LocaleKeys.shop_name.tr()} : ',
                    size: Constants().screenWidth(context) * 0.03)),
            AppTextStyle().textNormal('vTec Demo Store',
                size: Constants().screenWidth(context) * 0.03)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
                width: Constants().screenWidth(context) * 0.4,
                child: AppTextStyle().textBold('${LocaleKeys.pos_name.tr()} : ',
                    size: Constants().screenWidth(context) * 0.03)),
            AppTextStyle().textNormal('POS Demo',
                size: Constants().screenWidth(context) * 0.03)
          ],
        ),
      ],
    ),
  );
}
