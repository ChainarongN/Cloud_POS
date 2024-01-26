import 'package:cloud_pos/pages/menu/widgets/appbar_action.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu.dart';
import 'package:cloud_pos/pages/menu/widgets/recipe_item.dart';
import 'package:cloud_pos/pages/menu/widgets/tab_menu_title.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/menu_tab.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
      body: Padding(
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
                  Center(
                    child: Text("Search"),
                  ),
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

  Center favoriteTab1(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: List.generate(
                      menuWatch.getCategoryMenuTextList.length,
                      (index) => Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.126,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffff5895),
                              Color(0xfff85560),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xfff85560),
                                blurRadius: 8,
                                offset: Offset(0, 6)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: AppTextStyle().textNormal(
                              menuWatch.getCategoryMenuTextList[index],
                              size: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: NotificationListener<ScrollUpdateNotification>(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: 15,
                    itemCount: menuWatch.getMenuTextList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.06,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return RecipeItem(
                        recipeName: menuWatch.getMenuTextList[index]['name'],
                        recipeImage: menuWatch.getMenuTextList[index]['image'],
                      );
                    },
                  ),
                  onNotification: (notification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                    }
                    return true;
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 5),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.7,
              //   child: GridView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: menuRead.getMenuTextList.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       childAspectRatio: 1.06,
              //     ),
              //     itemBuilder: (BuildContext context, int index) {
              //       return RecipeItem(
              //         recipeName: menuWatch.getMenuTextList[index]['name'],
              //         recipeImage: menuWatch.getMenuTextList[index]['image'],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
