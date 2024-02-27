import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Column tabMenuTitle(BuildContext context, MenuProvider menuWatch) {
  return Column(
    children: [
      TabBar(
        controller: menuWatch.getTabController,
        tabs: <Widget>[
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('เมนู',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#1',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#2',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Search',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('ส่วนลด',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('จ่ายเงิน',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
