import 'package:cloud_pos/pages/menu/widgets/recipe_item.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Center favoriteTab1(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: List.generate(
                    menuWatch.prodGroupList!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        menuRead.setWhereMenu(menuWatch
                            .prodGroupList![index].productGroupID
                            .toString());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.126,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: menuWatch
                                        .prodGroupList![index].productGroupID ==
                                    menuWatch.getvalueMenuSelect
                                ? [
                                    const Color.fromARGB(255, 113, 134, 255),
                                    const Color.fromARGB(255, 157, 198, 255),
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
                                color: menuWatch.prodGroupList![index]
                                            .productGroupID ==
                                        menuWatch.getvalueMenuSelect
                                    ? const Color.fromARGB(255, 157, 198, 255)
                                    : const Color(0xfff85560),
                                blurRadius: 8,
                                offset: const Offset(0, 6)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: AppTextStyle().textNormal(
                              menuWatch.prodGroupList![index].productGroupName!,
                              size: 16,
                              color: Colors.white),
                        ),
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
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: menuWatch.prodToShow!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.06,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      menuRead.addProduct(context,
                          menuWatch.prodToShow![index].productID!, 1, '0');
                    },
                    child: RecipeItem(
                      recipeName: menuWatch.prodToShow![index].productName!,
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
