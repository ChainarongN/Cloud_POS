import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container usernameTablet(BuildContext context, LoginProvider loginWatch) {
  return Container(
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.024),
    width: Constants().screenWidth(context) * 0.3,
    child: TextField(
      controller: loginWatch.usernameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        labelText: LocaleKeys.username.tr(),
        border: Constants().myinputborder(), //normal border
        enabledBorder: Constants().myinputborder(), //enabled border
        focusedBorder: Constants().myfocusborder(), //focused border
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 25, right: 15),
          child: Icon(Icons.people),
        ),
      ),
      style: TextStyle(
          color: Constants.textColor,
          fontSize: Constants().fontSizeTL(context, Constants.normalSizeTL)),
    ),
  );
}
