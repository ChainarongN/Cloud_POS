import 'package:cloud_pos/pages/menu/tablet/widgets/appbar_action_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/coupon_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/manage_menu/manage_menu_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/reason_dialog_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tab_view_title_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/discount_tab_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/fav_one_tab_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/fav_two_tab_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/menu_tab_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/payment_tab_tablet.dart';
import 'package:cloud_pos/pages/menu/tablet/widgets/tabview/search_tab_tablet.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTablet extends StatefulWidget {
  const MenuTablet({super.key});

  @override
  State<MenuTablet> createState() => _MenuTabletState();
}

class _MenuTabletState extends State<MenuTablet>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<MenuProvider>().init(context, tabThis: this);
  }

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal(LocaleKeys.menu.tr()),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              openConfCancel(context, menuRead, menuWatch);
            }),
        actions: <Widget>[
          eCoupon(context, menuRead),
          memberTablet(context, menuRead, menuWatch),
          // employeeTablet(context),
          // clonebillTablet(context),
          holdBillTablet(context, menuRead),
        ],
      ),
      body: menuWatch.getLoading
          ? const LoaddingData()
          : Padding(
              padding:
                  EdgeInsets.all(Constants().screenheight(context) * 0.013),
              child: Container(
                width: Constants().screenWidth(context),
                height: Constants().screenheight(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Constants.primaryColor),
                  color: Constants.secondaryColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    manageMenu(context, menuWatch, menuRead),
                    tabViewAll(context, menuWatch, menuRead),
                  ],
                ),
              ),
            ),
    );
  }

  Expanded tabViewAll(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return Expanded(
      child: Column(
        children: [
          tabViewTitleTablet(context, menuWatch),
          Expanded(
            child: TabBarView(
              controller: menuWatch.getTabController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                menuTabTablet(context, menuWatch, menuRead),
                favoriteTab1Tablet(context, menuWatch, menuRead),
                favoriteTab2Tablet(context, menuWatch, menuRead),
                searchTabTablet(context, menuWatch, menuRead),
                discountTablet(context, menuWatch, menuRead),
                paymentTabTablet(context, menuRead, menuWatch),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
