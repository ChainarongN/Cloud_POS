import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDetailWidget extends StatefulWidget {
  const MenuDetailWidget({super.key});

  @override
  State<MenuDetailWidget> createState() => _MenuDetailWidgetState();
}

class _MenuDetailWidgetState extends State<MenuDetailWidget> {
  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    return Container(
      margin: EdgeInsets.only(
        top: Constants().screenheight(context) * 0.015,
      ),
      height: Constants().screenheight(context) * 0.56,
      width: Constants().screenWidth(context),
      child: GridView.builder(
        itemCount: menuWatch.prodToShow!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              menuRead.addProductToList(
                  context, menuWatch.prodToShow![index].productID!, 1, '0');
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
                    left: Constants().screenWidth(context) * 0.015,
                    right: Constants().screenWidth(context) * 0.015),
                child: AppTextStyle().textNormal(
                    menuWatch.prodToShow![index].productName!,
                    size:
                        Constants().screenWidth(context) * Constants.normalSize,
                    color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
