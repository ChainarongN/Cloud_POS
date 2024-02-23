import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GestureDetector btnLogin(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  return GestureDetector(
      onTap: () {
        if (loginWatch.apisState != ApiState.LOADING) {
          LoadingStyle().dialogLoadding(context);
          loginRead.flowOpen(context).then((value) {
            if (loginWatch.apisState == ApiState.COMPLETED) {
              Navigator.maybePop(context);
              Future.delayed(const Duration(milliseconds: 500), () {
                if (loginWatch.getOpenSession) {
                  loginRead.getOpenAmountController.text = '';
                  openAmountDialog(context, loginWatch, loginRead);
                } else {
                  Navigator.pushReplacementNamed(context, '/homePage');
                }
              });
            }
          });
        }
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: Constants().screenheight(context) * 0.02),
        child: ContainerStyle(
          height: Constants().screenheight(context) * 0.07,
          width: Constants().screenWidth(context) * 0.3,
          primaryColor: Colors.blue.shade400,
          secondaryColor: Colors.blue.shade400,
          selected: false,
          widget: AppTextStyle().textNormal(LocaleKeys.login.tr(),
              size: Constants().screenheight(context) * 0.024,
              color: Colors.white),
        ),
      ));
}

Future<void> openAmountDialog(
    BuildContext context, LoginProvider loginWatch, LoginProvider loginRead) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.15,
          child: Column(
            children: <Widget>[
              Container(
                width: Constants().screenWidth(context) * 0.2,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: loginWatch.getOpenAmountController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Open amount',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.025),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal('OK', size: 18),
            onPressed: () async {
              if (loginWatch.getOpenAmountController.text.isNotEmpty) {
                LoadingStyle().dialogLoadding(context);
                await loginRead.openSession(context).then((value) {
                  if (loginWatch.apisState == ApiState.COMPLETED) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/homePage', (route) => false);
                  }
                });
              }
            },
          ),
          TextButton(
            child: AppTextStyle()
                .textNormal('Cancel', size: 18, color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
