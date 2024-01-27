import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
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
              child: AppTextStyle().textBold('Merchant Name : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Restaurant', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle().textBold('Brand Name : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Brand', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle().textBold('Outlet Name : ', size: 16),
            ),
            AppTextStyle().textNormal('vTec Demo Store', size: 16)
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.11,
              child: AppTextStyle().textBold('POS Name : ', size: 16),
            ),
            AppTextStyle().textNormal('POS Demo', size: 16)
          ],
        ),
      ],
    ),
  );
}
