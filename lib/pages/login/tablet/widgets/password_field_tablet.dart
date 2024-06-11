import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SizedBox passwordTablet(
    BuildContext context, LoginProvider loginWatch, LoginProvider loginRead) {
  return SizedBox(
    width: Constants().screenWidth(context) * 0.3,
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        labelText: LocaleKeys.password.tr(),
        border: Constants().myinputborder(),
        enabledBorder: Constants().myinputborder(),
        focusedBorder: Constants().myfocusborder(),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 25, right: 15),
          child: Icon(Icons.lock),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            icon: loginWatch.passwordVisible
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () => loginRead.setPasswordVisible(),
          ),
        ),
      ),
      obscureText: loginWatch.passwordVisible,
      style: TextStyle(
          color: Constants.textColor,
          fontSize: Constants().screenheight(context) * 0.024),
    ),
  );
}
