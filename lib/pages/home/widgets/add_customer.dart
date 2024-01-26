import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Row addCustomer(HomeProvider homeWatch, HomeProvider homeRead) {
  return Row(
    children: [
      const Icon(Icons.person_4, color: Colors.black, size: 40.0),
      Container(
        width: 110,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 2),
        ),
        child: Center(
          child: AppTextStyle().textBold(
              homeWatch.getCountValue.toString(),
              color: Constants.textColor,
              size: 20),
        ),
      ),
      GestureDetector(
        onTap: () {
          homeRead.removeCount();
        },
        child: const Icon(Icons.remove_circle_outline,
            color: Colors.red, size: 45.0),
      ),
      const SizedBox(width: 18),
      GestureDetector(
        onTap: () {
          homeRead.addCount();
        },
        child: const Icon(Icons.add_circle_outline,
            color: Constants.primaryColor, size: 45.0),
      ),
    ],
  );
}
