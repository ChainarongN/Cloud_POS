// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class Constants {
  Constants._internal();
  static final Constants _instance = Constants._internal();
  factory Constants() => _instance;

  static const USER_INVALID_RESPONSE = 100;
  static const NO_INTERNET = 101;
  static const INVALID_FORMAT = 102;
  static const UNKNOWN_ERROR = 103;
  static const TIME_OUT = 408;
  static const SALE_MODE_TXT = 'sale_mode.txt';
  static const PROD_GROUP_TXT = 'prod_group.txt';
  static const PROD_TXT = 'prod.txt';
  static const FAV_GROUP_TXT = 'fav_group.txt';
  static const FAV_DATA_TXT = 'fav_data.txt';
  static const REASON_GROUP_TXT = 'rea_group.txt';
  static const PAYMENT_GROUP_TXT = 'payment_group.txt';
  static const SHOP_DATA_TXT = 'shop_data.txt';
  static const COMPUTER_NAME_TXT = 'computer_name.txt';
  static const INVALID_LOGIN =
      'This log in information is not registered to system.';

  static const primaryColor = Color(0xff87C4FF);
  static const secondaryColor = Color(0xffEEF5FF);
  static const textColor = Color(0xFF222B45);

  static const bgLogin = 'assets/bg_1.jpg';
  static const twentyImg = 'assets/images/twenty.png';
  static const fiftyImg = 'assets/images/fifty.png';
  static const one_hundredImg = 'assets/images/one_hundred.png';
  static const five_hundredImg = 'assets/images/five_hundred.png';
  static const thousandImg = 'assets/images/thousand.png';

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double screenheight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  void printInfo(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  void printWarning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  OutlineInputBorder myColorborder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: color),
    );
  }

  printCheckFlow(var first, var second) {
    Constants().printInfo(first.toString());
    Constants().printWarning(second.toString());
  }
}
