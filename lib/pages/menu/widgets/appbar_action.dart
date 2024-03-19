import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

Container clonebin(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.07,
    width: Constants().screenWidth(context) * 0.09,
    margin: const EdgeInsets.only(right: 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Constants.secondaryColor,
          Constants.primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Constants.primaryColor, blurRadius: 8, offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
      child: AppTextStyle().textNormal(LocaleKeys.clone_bill.tr(),
          size: Constants().screenheight(context) * 0.025),
    ),
  );
}

Container employee(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.07,
    width: Constants().screenWidth(context) * 0.09,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Constants.secondaryColor,
          Constants.primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Constants.primaryColor, blurRadius: 8, offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
      child: AppTextStyle().textNormal(LocaleKeys.employee.tr(),
          size: Constants().screenheight(context) * 0.025),
    ),
  );
}

GestureDetector member(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return GestureDetector(
    onTap: () {
      LoadingStyle().dialogLoadding(context);
      menuRead.orderSummary(context).then((value) {
        if (menuWatch.apiState == ApiState.COMPLETED) {
          Navigator.pop(context);
          if (menuWatch.orderSummaryModel!.responseObj!.tranData!.memberID ==
              0) {
            openNumberDialog(context, menuWatch, menuRead);
          } else {
            menuRead
                .memberData(context,
                    menuWatch.orderSummaryModel!.responseObj!.memberMobile!)
                .then((value) {
              if (menuWatch.apiState == ApiState.COMPLETED) {
                Navigator.maybePop(context);
                showMemberDetail(context, menuWatch, menuRead, true);
              }
            });
          }
        }
      });
    },
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.07,
      width: Constants().screenWidth(context) * 0.09,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Constants.secondaryColor,
            Constants.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
              color: Constants.primaryColor,
              blurRadius: 8,
              offset: Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
        child: AppTextStyle().textNormal(LocaleKeys.member.tr(),
            size: Constants().screenheight(context) * 0.025),
      ),
    ),
  );
}

Future<void> openNumberDialog(
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
                width: Constants().screenWidth(context) * 0.2,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: menuWatch.getPhoneMemberController,
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
                      fontSize: Constants().screenheight(context) * 0.025),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(), size: 18),
            onPressed: () async {
              if (menuWatch.getPhoneMemberController.text.length == 12) {
                LoadingStyle().dialogLoadding(context);
                // final phoneReplace =
                //     menuWatch.getPhoneMemberController.text.replaceAll('-', '');
                String phoneReplace = '0836869334';
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
                size: 18, color: Colors.red),
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
          height: Constants().screenheight(context) * 0.26,
          child: Padding(
            padding: EdgeInsets.all(Constants().screenheight(context) * 0.018),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                            Constants().screenheight(context) * 0.018),
                        child: Column(
                          children: <Widget>[
                            AppTextStyle().textBold(
                                LocaleKeys.member_points.tr(),
                                size:
                                    Constants().screenheight(context) * 0.024),
                            AppTextStyle().textNormal(
                                menuWatch.memberDataModel!.responseObj!
                                    .memberInfo!.memberPoints
                                    .toString(),
                                size: Constants().screenheight(context) * 0.024)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                            Constants().screenheight(context) * 0.018),
                        child: Column(
                          children: <Widget>[
                            AppTextStyle().textBold(
                                LocaleKeys.member_cash_balance.tr(),
                                size:
                                    Constants().screenheight(context) * 0.024),
                            AppTextStyle().textNormal(
                                menuWatch.memberDataModel!.responseObj!
                                    .memberInfo!.memberCashBalance
                                    .toString(),
                                size: Constants().screenheight(context) * 0.023)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.018),
                  child: Row(
                    children: <Widget>[
                      AppTextStyle().textBold(
                          '${LocaleKeys.first_name.tr()} : ',
                          size: Constants().screenheight(context) * 0.023),
                      AppTextStyle().textNormal(
                          menuWatch.memberDataModel!.responseObj!.memberInfo!
                              .memberFirstName!,
                          size: Constants().screenheight(context) * 0.023)
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
                          size: Constants().screenheight(context) * 0.023),
                      AppTextStyle().textNormal(
                          menuWatch.memberDataModel!.responseObj!.memberInfo!
                              .memberGroupName!,
                          size: Constants().screenheight(context) * 0.023)
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
                      size: 18, color: Colors.red),
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
                  child: AppTextStyle()
                      .textNormal(LocaleKeys.apply.tr(), size: 18),
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
                size: 18, color: Colors.grey),
            onPressed: () async {
              Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
            },
          ),
        ],
      );
    },
  );
}
