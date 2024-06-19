import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTitleWidget extends StatelessWidget {
  const MenuTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.start,
      children: <Widget>[
        MenuBtn(text: 'Menu', valueId: 0),
        MenuBtn(text: 'Favorite#1', valueId: 1),
        MenuBtn(text: 'Favorite#2', valueId: 2),
      ],
    );
  }
}

class MenuBtn extends StatelessWidget {
  final String text;
  final int valueId;
  const MenuBtn({super.key, required this.text, required this.valueId});

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    return GestureDetector(
      onTap: () {
        menuRead.setValueTitle(valueId);
      },
      child: Container(
        margin: EdgeInsets.only(
          right: Constants().screenWidth(context) * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: valueId == menuWatch.getvalueTitleSelect
              ? Constants.primaryColor
              : Constants.secondaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: Constants().screenheight(context) * 0.01,
            bottom: Constants().screenheight(context) * 0.01,
            left: Constants().screenWidth(context) * 0.055,
            right: Constants().screenWidth(context) * 0.055,
          ),
          child: AppTextStyle().textBold(text,
              size: Constants().screenWidth(context) * Constants.normalSize,
              color: valueId == menuWatch.getvalueTitleSelect
                  ? Colors.white
                  : Colors.black87),
        ),
      ),
    );
  }
}
