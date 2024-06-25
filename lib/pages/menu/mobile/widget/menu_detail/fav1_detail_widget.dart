import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fav1DetailWidget extends StatefulWidget {
  const Fav1DetailWidget({super.key});

  @override
  State<Fav1DetailWidget> createState() => _Fav1DetailWidgetState();
}

class _Fav1DetailWidgetState extends State<Fav1DetailWidget> {
  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    return menuWatch.favResultList!.isEmpty
        ? Container(
            margin:
                EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
            height: Constants().screenheight(context) * 0.62,
            width: Constants().screenWidth(context),
          )
        : Container(
            margin:
                EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
            height: Constants().screenheight(context) * 0.62,
            width: Constants().screenWidth(context),
            child:
                // ReorderableGridView.count
                GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 8,
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
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(
                                Constants().hexStringToColorFF(item.hexColor!)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(Constants()
                                      .hexStringToColorF2(item.hexColor!)),
                                  blurRadius: 8,
                                  offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Constants().screenheight(context) * 0.015,
                                right:
                                    Constants().screenheight(context) * 0.015),
                            child: AppTextStyle().textNormal(
                                menuRead.getProdName(item.productID!),
                                size: Constants().screenWidth(context) *
                                    Constants.normalSize,
                                color: Colors.black),
                          ),
                        ),
                      );
              }).toList(),
            ),
          );
  }
}
