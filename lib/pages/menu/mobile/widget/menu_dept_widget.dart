import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDeptWidget extends StatelessWidget {
  const MenuDeptWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var menuWatch = context.watch<MenuProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(
          menuWatch.prodDeptList!.length,
          (index) => menuWatch.prodDeptList![index].productGroupID !=
                  menuWatch.getvalueMenuSelect
              ? const SizedBox.shrink()
              : MenuBtn(
                  text: menuWatch.prodDeptList![index].productDeptName!,
                  valueId: menuWatch.prodDeptList![index].productDeptID!,
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
    return GestureDetector(
      onTap: () {
        menuRead.showMenuList(context, false, prodDeptId: valueId);
      },
      child: Container(
        margin: EdgeInsets.only(
          right: Constants().screenWidth(context) * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: valueId == menuWatch.getValueDept
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
              color: valueId == menuWatch.getValueDept
                  ? Colors.white
                  : Colors.black87),
        ),
      ),
    );
  }
}
