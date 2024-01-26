import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._internal();
  static final AppTextStyle _instance = AppTextStyle._internal();
  factory AppTextStyle() => _instance;

  Text textBold(String name, {double? size, Color? color}) {
    color ?? Constants.textColor;
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
        overflow: TextOverflow.fade,
      ),
      maxLines: 2,
    );
  }

  Text textNormal(String name, {double? size, Color? color}) {
    color ?? Constants.textColor;

    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: color,
        overflow: TextOverflow.fade,
      ),
      maxLines: 2,
    );
  }
}
