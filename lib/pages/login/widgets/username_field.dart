import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container username(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    width: MediaQuery.of(context).size.width * 0.3,
    child: TextField(
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
      style: const TextStyle(color: Constants.textColor, fontSize: 20),
    ),
  );
}
