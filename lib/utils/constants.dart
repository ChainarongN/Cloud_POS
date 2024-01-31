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

  static const primaryColor = Color(0xff87C4FF);
  static const secondaryColor = Color(0xffEEF5FF);
  static const textColor = Color(0xFF222B45);

  static const bgLogin = 'assets/bg_1.jpg';

  void printInfo(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  void printWarning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }
}
