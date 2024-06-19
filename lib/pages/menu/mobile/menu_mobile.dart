import 'package:cloud_pos/pages/menu/mobile/widget/drawer_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menugroup_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/menutitle_widget.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/searchbar_widget.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal(LocaleKeys.menu.tr()),
      ),
      drawer: drawerWidget(context),
      body: menuWatch.getLoading
          ? const LoaddingData()
          : Padding(
              padding: EdgeInsets.only(
                  top: Constants().screenWidth(context) * 0.045,
                  left: Constants().screenWidth(context) * 0.045,
                  right: Constants().screenWidth(context) * 0.045),
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
                  Container(
                    margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.015,
                    ),
                    height: Constants().screenheight(context) * 0.62,
                    width: Constants().screenWidth(context),
                    child: GridView.builder(
                      itemCount: menuWatch.prodToShow!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 8),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // menuRead.addProductToList(
                            //     context,
                            //     menuWatch.prodToShow![index].productID!,
                            //     1,
                            //     '0');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 157, 198, 255),
                                  Color.fromARGB(255, 157, 198, 255),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 157, 198, 255),
                                    blurRadius: 8,
                                    offset: Offset(0, 6)),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      Constants().screenWidth(context) * 0.015,
                                  right:
                                      Constants().screenWidth(context) * 0.015),
                              child: AppTextStyle().textNormal(
                                  menuWatch.prodToShow![index].productName!,
                                  size: Constants().screenWidth(context) *
                                      Constants.normalSize,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
