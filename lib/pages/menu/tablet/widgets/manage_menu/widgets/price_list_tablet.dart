import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Row priceListTablet(BuildContext context, MenuProvider menuRead) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '50');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Constants.primaryColor,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('50',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '100');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.red.shade400,
            boxShadow: const [
              BoxShadow(color: Colors.red, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('100',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '500');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.purple.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.purple, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('500',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.paymentCash(context: context, payAmount: '1000');
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.065,
          height: Constants().screenheight(context) * 0.1,
          margin: EdgeInsets.all(Constants().screenheight(context) * 0.0015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('1000',
                    size: Constants().screenheight(context) * 0.035),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
