import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuGroupWidget extends StatelessWidget {
  const MenuGroupWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var menuWatch = context.watch<MenuProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: menuWatch.getvalueTitleSelect == 0
          ? Wrap(
              alignment: WrapAlignment.start,
              children: List.generate(
                menuWatch.prodGroupList!.length,
                (index) => MenuBtn(
                  text: menuWatch.prodGroupList![index].productGroupName!,
                  valueId: menuWatch.prodGroupList![index].productGroupID!,
                ),
              ),
            )
          : menuWatch.getvalueTitleSelect == 1
              ? Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    menuWatch.favoriteGroupList!.length,
                    (index) => menuWatch.favoriteGroupList![index].pageType == 1
                        ? const SizedBox.shrink()
                        : MenuBtn(
                            text: menuWatch.favoriteGroupList![index].pageName!,
                            valueId:
                                menuWatch.favoriteGroupList![index].pageIndex!,
                          ),
                  ),
                )
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    menuWatch.favoriteGroupList!.length,
                    (index) => menuWatch.favoriteGroupList![index].pageType == 0
                        ? const SizedBox.shrink()
                        : MenuBtn(
                            text: menuWatch.favoriteGroupList![index].pageName!,
                            valueId:
                                menuWatch.favoriteGroupList![index].pageIndex!,
                          ),
                  ),
                ),
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
    int valueSelect;
    if (menuWatch.getvalueTitleSelect == 0) {
      valueSelect = menuWatch.getvalueMenuSelect;
    } else {
      valueSelect = menuWatch.getValueFavGroup;
    }
    return GestureDetector(
      onTap: () {
        switch (menuWatch.getvalueTitleSelect) {
          case 0:
            // menuRead.setWhereMenu(valueId.toString());
            menuRead.showMenuList(context, true, prodGroupId: valueId);
            break;
          case 1:
            menuRead.showFavList(context, valueId);
            break;
          case 2:
            menuRead.showFavList(context, valueId);
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          right: Constants().screenWidth(context) * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: valueId == valueSelect
              ? Constants.primaryColor
              : Constants.secondaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: Constants().screenheight(context) * 0.014,
            bottom: Constants().screenheight(context) * 0.014,
            left: Constants().screenWidth(context) * 0.055,
            right: Constants().screenWidth(context) * 0.055,
          ),
          child: AppTextStyle().textBold(text,
              size: Constants().screenWidth(context) * Constants.normalSize,
              color: valueId == valueSelect ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
