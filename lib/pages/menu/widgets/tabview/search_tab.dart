import 'package:cloud_pos/pages/menu/widgets/recipe_item.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

Center searchTab(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) {
                  menuRead.searchMenu(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Constants.primaryColor.withOpacity(0.3),
                  labelText: "Search",
                  border: Constants().myinputborder(),
                  enabledBorder: Constants().myinputborder(),
                  focusedBorder: Constants().myfocusborder(),
                  contentPadding: const EdgeInsets.only(left: 40),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 35),
                    child: Icon(Icons.search),
                  ),
                ),
                style:
                    const TextStyle(color: Constants.textColor, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: menuWatch.prodToSearch!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      menuRead.addProduct(context,
                          menuWatch.prodToSearch![index].productID!, 1, '0');
                    },
                    child: RecipeItem(
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
