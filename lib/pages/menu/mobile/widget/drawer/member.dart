import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

Future<void> openNumberMemberDialog(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  menuRead.clearField();
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
                width: Constants().screenWidth(context),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: menuWatch.phoneMemberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    MaskedInputFormatter('###-###-####',
                        allowedCharMatcher: RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: LocaleKeys.phone_number.tr(),
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenWidth(context) *
                          Constants.normalSize),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize),
            onLongPress: () {
              menuRead.setPhoneMemberForTest();
            },
            onPressed: () async {
              if (menuWatch.phoneMemberController.text.length == 12) {
                LoadingStyle().dialogLoadding(context);
                final phoneReplace =
                    menuWatch.phoneMemberController.text.replaceAll('-', '');
                // String phoneReplace = '0836869334';
                await menuRead.memberData(context, phoneReplace).then((value) {
                  if (menuWatch.apiState == ApiState.COMPLETED) {
                    Navigator.maybePop(context);
                    showMemberDetail(context, menuWatch, menuRead, false);
                  }
                });
              }
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

showMemberDetail(BuildContext context, MenuProvider menuWatch,
    MenuProvider menuRead, bool isApply) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.34,
          child: Padding(
            padding: EdgeInsets.all(Constants().screenheight(context) * 0.018),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: Constants().screenWidth(context),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          Constants().screenheight(context) * 0.018),
                      child: Column(
                        children: <Widget>[
                          AppTextStyle().textBold(
                              LocaleKeys.member_cash_balance.tr(),
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                          AppTextStyle().textNormal(
                              menuWatch.memberDataModel!.responseObj!
                                  .memberInfo!.memberCashBalance
                                  .toString(),
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Constants().screenWidth(context),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          Constants().screenheight(context) * 0.018),
                      child: Column(
                        children: <Widget>[
                          AppTextStyle().textBold(LocaleKeys.member_points.tr(),
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                          AppTextStyle().textNormal(
                              menuWatch.memberDataModel!.responseObj!
                                  .memberInfo!.memberPoints
                                  .toString(),
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.018),
                  child: Row(
                    children: <Widget>[
                      AppTextStyle().textBold(
                          '${LocaleKeys.first_name.tr()} : ',
                          size: Constants().screenWidth(context) *
                              Constants.normalSize),
                      AppTextStyle().textNormal(
                          menuWatch.memberDataModel!.responseObj!.memberInfo!
                              .memberFirstName!,
                          size: Constants().screenWidth(context) *
                              Constants.normalSize)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.01),
                  child: Row(
                    children: <Widget>[
                      AppTextStyle().textBold(
                          '${LocaleKeys.group_name.tr()} : ',
                          size: Constants().screenWidth(context) *
                              Constants.normalSize),
                      AppTextStyle().textNormal(
                          menuWatch.memberDataModel!.responseObj!.memberInfo!
                              .memberGroupName!,
                          size: Constants().screenWidth(context) *
                              Constants.normalSize)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          isApply
              ? TextButton(
                  child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSize,
                      color: Colors.red),
                  onPressed: () async {
                    LoadingStyle().dialogLoadding(context);
                    menuRead.memberCancel(context).then((value) {
                      if (menuWatch.apiState == ApiState.COMPLETED) {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/menuPage'));
                      }
                    });
                  },
                )
              : TextButton(
                  child: AppTextStyle().textNormal(LocaleKeys.apply.tr(),
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                  onPressed: () async {
                    LoadingStyle().dialogLoadding(context);
                    menuRead.memberApply(context).then((value) {
                      if (menuWatch.apiState == ApiState.COMPLETED) {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/menuPage'));
                      }
                    });
                  },
                ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.close.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize,
                color: Colors.grey),
            onPressed: () async {
              Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
            },
          ),
        ],
      );
    },
  );
}
