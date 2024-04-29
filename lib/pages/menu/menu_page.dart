import 'package:cloud_pos/pages/menu/widgets/appbar_action.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu/manage_menu.dart';
import 'package:cloud_pos/pages/menu/widgets/reason_dialog.dart';
import 'package:cloud_pos/pages/menu/widgets/tab_view_title.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/discount_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/fav_one_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/fav_two_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/menu_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/payment_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/search_tab.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<MenuProvider>().init(context, this);
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
              openConfCancel(context, menuRead);
            }),
        actions: <Widget>[
          member(context, menuRead, menuWatch),
          employee(context),
          clonebill(context),
          holdBill(context, menuRead),
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
          tabViewTitle(context, menuWatch),
          Expanded(
            child: TabBarView(
              controller: menuWatch.getTabController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                menuTab(context, menuWatch, menuRead),
                favoriteTab1(context, menuWatch, menuRead),
                favoriteTab2(context, menuWatch, menuRead),
                searchTab(context, menuWatch, menuRead),
                discount(context, menuWatch, menuRead),
                paymentTab(context, menuRead, menuWatch),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
