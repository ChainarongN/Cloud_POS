import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/coupon_list.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/order_detail.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/order_list.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/order_title.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/price_list.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/widgets/summary_btn.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

Card manageMenu(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Card(
    child: Container(
      color: Colors.white,
      width: Constants().screenWidth(context) * 0.33,
      height: Constants().screenheight(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              orderTitle(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderList(menuWatch, menuRead, context),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderDetail(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              couponList(context, menuRead, menuWatch),
              summaryBtn(context, menuWatch, menuRead),
              priceList(context, menuRead)
            ],
          ),
        ),
      ),
    ),
  );
}
