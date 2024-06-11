import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Container setLanguageTablet(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  return Container(
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(right: Constants().screenheight(context) * 0.06),
          width: Constants().screenWidth(context) * 0.09,
          height: Constants().screenheight(context) * 0.084,
          child: dropdownButton(context,
              loginRead: loginRead,
              loginWatch: loginWatch,
              itemMap: loginWatch.getLanguageList,
              value: context.locale.languageCode.toUpperCase(),
              onChanged: (value) {
            loginRead.setLanguage(context, value!);
          }),
        ),
      ],
    ),
  );
}

DropdownButtonFormField2<String> dropdownButton(BuildContext context,
    {LoginProvider? loginWatch,
    LoginProvider? loginRead,
    List<String>? itemMap,
    String? value,
    Function(String?)? onChanged}) {
  return DropdownButtonFormField2<String>(
    isDense: false,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    value: value,
    items: itemMap!.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: Constants().screenheight(context) * 0.018,
          ),
        ),
      );
    }).toList(),
    onChanged: onChanged,
    iconStyleData: IconStyleData(
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: Constants().screenheight(context) * 0.033,
    ),
  );
}
