import 'package:cloud_pos/pages/menu/widgets/recipe_item.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

Center favoriteTab2(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.006),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: Constants().screenheight(context) * 0.013,
                    top: Constants().screenheight(context) * 0.005),
                child: Row(
                  children: List.generate(
                    menuWatch.favoriteGroupList!.length,
                    (index) => menuWatch.favoriteGroupList![index].pageType == 0
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              menuRead.showFav1List(
                                  context,
                                  menuWatch
                                      .favoriteGroupList![index].pageIndex!);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Constants().screenheight(context) * 0.07,
                              width: Constants().screenWidth(context) * 0.126,
                              margin: EdgeInsets.only(
                                  right: Constants().screenheight(context) *
                                      0.007),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: menuWatch.favoriteGroupList![index]
                                              .pageIndex ==
                                          menuWatch.getValueFavGroup
                                      ? [
                                          const Color.fromARGB(
                                              255, 113, 134, 255),
                                          const Color.fromARGB(
                                              255, 157, 198, 255),
                                        ]
                                      : [
                                          const Color(0xffff5895),
                                          const Color(0xfff85560),
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: menuWatch.favoriteGroupList![index]
                                                  .pageIndex ==
                                              menuWatch.getValueFavGroup
                                          ? const Color.fromARGB(
                                              255, 157, 198, 255)
                                          : const Color(0xfff85560),
                                      blurRadius: 8,
                                      offset: const Offset(0, 6)),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Constants().screenheight(context) *
                                        0.007,
                                    right: Constants().screenheight(context) *
                                        0.007),
                                child: AppTextStyle().textNormal(
                                    menuWatch
                                        .favoriteGroupList![index].pageName!,
                                    size: Constants().screenheight(context) *
                                        0.023,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            menuWatch.favResultList!.isEmpty
                ? Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.007),
                    width: Constants().screenWidth(context),
                    height: Constants().screenheight(context) * 0.7,
                  )
                : Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.007),
                    width: Constants().screenWidth(context),
                    height: Constants().screenheight(context) * 0.7,
                    child: ReorderableGridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 3,
                      childAspectRatio: 1.06,
                      shrinkWrap: true,
                      onReorder: (oldIndex, newIndex) {
                        menuRead.reOrderableDataFav(
                            context, oldIndex, newIndex);
                      },
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
                                child: RecipeItem(
                                  recipeName:
                                      menuRead.getProdName(item.productID!),
                                  recipeImage: 'assets/coffee2.jpg',
                                ),
                              );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
