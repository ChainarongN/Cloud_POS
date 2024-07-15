import 'package:cloud_pos/pages/menu/mobile/widget/change_sale_mode.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menu_detail/fav1_detail_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menu_detail/fav2_detail_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menu_detail/menu_detail_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menugroup_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menutitle_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/searchbar/searchbar_widget.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuMobile extends StatefulWidget {
  const MenuMobile({super.key});

  @override
  State<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends State<MenuMobile> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuProvider>(context, listen: false).init(context);
  }

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    var homeWatch = context.watch<HomeProvider>();
    var homeRead = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal(LocaleKeys.menu.tr()),
        actions: [
          Container(
            margin:
                EdgeInsets.only(right: Constants().screenWidth(context) * 0.05),
            child: GestureDetector(
              onTap: () {
                changeSaleModeDialog(
                    context, homeWatch, homeRead, menuRead, menuWatch);
              },
              child: Row(
                children: [
                  AppTextStyle().textNormal('SaleMode : '),
                  AppTextStyle().textBold(
                      menuWatch.transactionModel!.responseObj!.saleModeName!),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )
        ],
      ),
      drawer: drawerWidget(context),
      floatingActionButton: Badge(
        isLabelVisible:
            menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
                ? false
                : true,
        label: AppTextStyle().textNormal(menuWatch
            .transactionModel!.responseObj!.orderList!.length
            .toString()),
        child: FloatingActionButton(
          onPressed: () {
            if (menuWatch
                .transactionModel!.responseObj!.orderList!.isNotEmpty) {
              Navigator.pushNamed(context, '/shopingCartPage');
            }
          },
          backgroundColor: Constants.secondaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      body: menuWatch.getLoading
          ? const LoadingData()
          : Padding(
              padding: EdgeInsets.only(
                  top: Constants().screenWidth(context) * 0.045,
                  left: Constants().screenWidth(context) * 0.045,
                  right: Constants().screenWidth(context) * 0.045),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SearchBarWidget(),
                    const MenuTitleWidget(),
                    Container(
                      margin: EdgeInsets.only(
                          top: Constants().screenheight(context) * 0.01),
                      child: const Divider(thickness: 0.5),
                    ),
                    const MenuGroupWidget(),

                    ///////////////////////////////////////////

                    menuWatch.getvalueTitleSelect == 0
                        ? const MenuDetailWidget()
                        : menuWatch.getvalueTitleSelect == 1
                            ? const Fav1DetailWidget()
                            : const Fav2DetailWidget(),
                  ],
                ),
              ),
            ),
    );
  }
}
