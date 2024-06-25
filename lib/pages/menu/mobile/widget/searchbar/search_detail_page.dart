import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/recipe_item_mobile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDetailPage extends StatefulWidget {
  const SearchDetailPage({super.key});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MenuProvider>(context, listen: false).searchMenu('');
  }

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: Constants().screenWidth(context) * 0.045,
            left: Constants().screenWidth(context) * 0.045,
            right: Constants().screenWidth(context) * 0.045),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: Constants().screenheight(context) * 0.02,
                ),
                width: Constants().screenWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.primaryColor.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    menuRead.searchMenu(value);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Constants.primaryColor.withOpacity(0.3),
                    hintText: LocaleKeys.search.tr(),
                    border: Constants().myinputborder(),
                    enabledBorder: Constants().myinputborder(),
                    focusedBorder: Constants().myfocusborder(),
                    contentPadding: const EdgeInsets.only(left: 40),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 35),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: Constants().screenWidth(context),
                height: Constants().screenheight(context) * 0.75,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: menuWatch.prodToSearch!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        menuRead.addProductToList(context,
                            menuWatch.prodToSearch![index].productID!, 1, '0');
                      },
                      child: RecipeItemMobile(
                        recipeName: menuWatch.prodToSearch![index].productName!,
                        recipeImage: 'assets/coffee2.jpg',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
