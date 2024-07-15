import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> openHoldBillDialog(BuildContext context, MenuProvider menuRead) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.24,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Name',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenWidth(context) *
                          Constants.normalSize),
                  onChanged: (value) {
                    menuRead.holdBillName = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Phone Number',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenWidth(context) *
                          Constants.normalSize),
                  onChanged: (value) {
                    menuRead.holdBillPhone = value;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize),
            onPressed: () async {
              DialogStyle().dialogLoadding(context);
              menuRead.holdBill(context).then((value) async {
                if (menuRead.apiState == ApiState.COMPLETED) {
                  var homePvd = context.read<HomeProvider>();
                  await homePvd.openTransaction(context).then((value) {
                    if (homePvd.apisState == ApiState.COMPLETED) {
                      menuRead
                          .setTranData(
                              tranModel: json.encode(homePvd.openTranModel))
                          .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/menuPage', (route) => false);
                      });
                    }
                  });
                }
              });
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
