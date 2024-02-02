import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container merchantDetail(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 30),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle()
                  .textBold('${LocaleKeys.merchant_name.tr()} : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Restaurant', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle()
                  .textBold('${LocaleKeys.brand_name.tr()} : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Brand', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle()
                  .textBold('${LocaleKeys.shop_name.tr()} : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Demo Store', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle()
                  .textBold('${LocaleKeys.pos_name.tr()} : ', size: 16),
            ),
            AppTextStyle().textNormal('POS Demo', size: 16)
          ],
        ),
      ],
    ),
  );
}
