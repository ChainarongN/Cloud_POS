import 'package:cloud_pos/pages/menu/tablet/widgets/coupon_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/widgets/order_detail_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/widgets/order_list_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/widgets/order_title_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/widgets/price_list_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/widgets/summary_btn_tablet.dart';
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
              orderTitleTablet(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderListTablet(menuWatch, menuRead, context),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderDetailTablet(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              // summaryBtnTablet(context, menuWatch, menuRead),
              priceListTablet(context, menuRead, menuWatch)
            ],
          ),
        ),
      ),
    ),
  );
}
