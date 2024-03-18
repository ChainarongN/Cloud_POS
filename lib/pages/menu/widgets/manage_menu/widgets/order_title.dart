import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

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