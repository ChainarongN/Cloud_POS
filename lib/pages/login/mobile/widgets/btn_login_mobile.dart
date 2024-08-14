// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';

GestureDetector btnLoginMobile(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  var homePvd = Provider.of<HomeProvider>(context, listen: false);
  var menuPvd = Provider.of<MenuProvider>(context, listen: false);
  return GestureDetector(
      onLongPress: () {
        loginRead.setUsernameForTest();
      },
      onTap: () async {
        String baseUrl = await loginWatch.getBaseUrl();
        if (baseUrl.isEmpty) {
          DialogStyle().dialogError(context,
              isPopUntil: false,
              error: 'Please setting your "Base url" in Config');
        } else {
          if (loginWatch.deviceController.text.isEmpty) {
            openDeviceIdDialog(context, loginWatch, loginRead);
          } else {
            DialogStyle().dialogLoadding(context);
            loginRead.flowOpen(context).then((value) async {
              if (loginWatch.apisState == ApiState.COMPLETED) {
                if (loginWatch.getOpenSession) {
                  Navigator.maybePop(context);
                  loginRead.openAmountController.text = '';
                  openAmountDialog(context, loginWatch, loginRead);
                } else {
                  await homePvd.openTransaction(context).then((value) {
                    if (homePvd.apisState == ApiState.COMPLETED) {
                      menuPvd
                          .setTranData(
                              tranModel: json.encode(homePvd.openTranModel))
                          .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/menuPage', (route) => false);
                      });
                    }
                  });
                }
              }
            });
          }
        }
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: Constants().screenheight(context) * 0.02),
        child: ContainerStyle(
          height: Constants().screenheight(context) * 0.07,
          width: Constants().screenWidth(context) * 0.7,
          primaryColor: Colors.blue.shade400,
          secondaryColor: Colors.blue.shade400,
          selected: false,
          widget: AppTextStyle().textNormal(LocaleKeys.login.tr(),
              size: Constants().fontSizeMB(context, Constants.boldSizeMB),
              color: Colors.white),
        ),
      ));
}

Future<void> openDeviceIdDialog(
    BuildContext context, LoginProvider loginWatch, LoginProvider loginRead) {
  var configPvd = Provider.of<ConfigProvider>(context, listen: false);
  loginRead.deviceController.text = '';
  var homePvd = Provider.of<HomeProvider>(context, listen: false);
  var menuPvd = Provider.of<MenuProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.17,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  maxLength: 19,
                  keyboardType: TextInputType.number,
                  controller: loginWatch.deviceController,
                  inputFormatters: <TextInputFormatter>[
                    MaskedInputFormatter('####-####-####-####',
                        allowedCharMatcher: RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Device Id',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.02),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal('OK',
                size: Constants().fontSizeMB(context, Constants.normalSizeMB)),
            onLongPress: () {
              loginRead.setMockDeviceId();
            },
            onPressed: () async {
              await configPvd.setDeviceID(loginWatch.deviceController.text);
              DialogStyle().dialogLoadding(context);
              loginRead.flowOpen(context).then((value) {
                if (loginWatch.apisState == ApiState.COMPLETED) {
                  Navigator.maybePop(context);
                  Future.delayed(const Duration(milliseconds: 500), () async {
                    if (loginWatch.getOpenSession) {
                      loginRead.openAmountController.text = '';
                      openAmountDialog(context, loginWatch, loginRead);
                    } else {
                      await homePvd.openTransaction(context).then((value) {
                        if (homePvd.apisState == ApiState.COMPLETED) {
                          menuPvd
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
                }
              });
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal('Cancel',
                size: Constants().fontSizeMB(context, Constants.normalSizeMB),
                color: Colors.red),
            onPressed: () async {
              Navigator.of(context).popUntil(ModalRoute.withName("/loginPage"));
            },
          ),
        ],
      );
    },
  );
}

Future<void> openAmountDialog(
    BuildContext context, LoginProvider loginWatch, LoginProvider loginRead) {
  var homePvd = Provider.of<HomeProvider>(context, listen: false);
  var menuPvd = Provider.of<MenuProvider>(context, listen: false);
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
                // width: Constants().screenWidth(context) * 0.2,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: loginWatch.openAmountController,
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
            child: AppTextStyle().textNormal('OK',
                size: Constants().fontSizeMB(context, Constants.normalSizeMB)),
            onPressed: () async {
              if (loginWatch.openAmountController.text.isNotEmpty) {
                DialogStyle().dialogLoadding(context);
                await loginRead.openSession(context).then((value) async {
                  if (loginWatch.apisState == ApiState.COMPLETED) {
                    await homePvd.openTransaction(context).then((value) {
                      if (homePvd.apisState == ApiState.COMPLETED) {
                        menuPvd
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
              }
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal('Cancel',
                size: Constants().fontSizeMB(context, Constants.normalSizeMB),
                color: Colors.red),
            onPressed: () async {
              Navigator.of(context).popUntil(ModalRoute.withName("/loginPage"));
            },
          ),
        ],
      );
    },
  );
}
