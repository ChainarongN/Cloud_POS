import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Column tabMenuTitle() {
  return Column(
    children: [
      TabBar(
        tabs: <Widget>[
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('เมนู', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#1', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#2', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Search', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('ส่วนลด', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('จ่ายเงิน', size: 16),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}