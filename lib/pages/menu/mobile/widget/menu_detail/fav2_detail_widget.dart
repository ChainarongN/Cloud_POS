import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/recipe_item_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fav2DetailWidget extends StatefulWidget {
  const Fav2DetailWidget({super.key});

  @override
  State<Fav2DetailWidget> createState() => _Fav2DetailWidgetState();
}

class _Fav2DetailWidgetState extends State<Fav2DetailWidget> {
  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    return menuWatch.favResultList!.isEmpty
        ? Container(
            margin:
                EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
            width: Constants().screenWidth(context),
            height: Constants().screenheight(context) * 0.62,
          )
        : Container(
            margin:
                EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
            width: Constants().screenWidth(context),
            height: Constants().screenheight(context) * 0.62,
            child:
                // ReorderableGridView.count
                GridView.count(
              crossAxisCount: 2,
              // onReorder: (oldIndex, newIndex) {
              //   menuRead.reOrderableDataFav(
              //       context, oldIndex, newIndex);
              // },
              children: menuWatch.favResultList!.map((item) {
                return item.productID == 0
                    ? Card(
                        elevation: 2,
                        key: ValueKey(item),
                      )
                    : GestureDetector(
                        key: ValueKey(item),
                        onTap: () {
                          menuRead.addProductToList(
                              context, item.productID!, 1, '0');
                        },
                        child: RecipeItemMobile(
                          recipeName: menuRead.getProdName(item.productID!),
                          recipeImage: 'assets/coffee2.jpg',
                        ),
                      );
              }).toList(),
            ),
          );
  }
}
