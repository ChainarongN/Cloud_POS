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
                  shrinkWrap: true,
                  // itemCount: 15,
                  itemCount: menuWatch.getMenuTextList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                  }
                  return true;
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
