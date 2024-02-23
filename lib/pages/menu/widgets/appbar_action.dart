import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Container clonebin(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.06,
    width: Constants().screenWidth(context) * 0.09,
    margin: const EdgeInsets.only(right: 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Constants.secondaryColor,
          Constants.primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Constants.primaryColor, blurRadius: 8, offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: AppTextStyle().textNormal('โคลนบิล', size: 16),
    ),
  );
}

Container employee(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.06,
    width: Constants().screenWidth(context) * 0.09,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Constants.secondaryColor,
          Constants.primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Constants.primaryColor, blurRadius: 8, offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: AppTextStyle().textNormal('พนักงาน', size: 16),
    ),
  );
}

Container member(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.06,
    width: Constants().screenWidth(context) * 0.09,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Constants.secondaryColor,
          Constants.primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Constants.primaryColor, blurRadius: 8, offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: AppTextStyle().textNormal('สมาชิก', size: 16),
    ),
  );
}
