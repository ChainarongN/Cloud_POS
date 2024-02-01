import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/widgets/appbar_action.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu.dart';
import 'package:cloud_pos/pages/menu/widgets/tab_menu_title.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/fav_one_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/menu_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/search_tab.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/error_widget.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<MenuProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('Menu'),
        actions: <Widget>[
          employee(context),
          member(context),
          clonebin(context),
        ],
      ),
      body: menuWatch.apiState == ApiState.LOADING
          ? const LoaddingData()
          : menuWatch.apiState == ApiState.ERROR
              ? CustomErrorWidget(errorMessage: menuWatch.getExceptionText)
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants.primaryColor),
                      color: Constants.secondaryColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // listItem(menuWatch, context),
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
      child: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            tabMenuTitle(),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  menuTab(context, menuWatch, menuRead),
                  favoriteTab1(context, menuWatch, menuRead),
                  Center(
                    child: Text("Fav#2"),
                  ),
                  searchTab(context, menuWatch, menuRead),
                  Center(
                    child: Text("ส่วนลด"),
                  ),
                  Center(
                    child: Text("จ่ายเงิน"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
