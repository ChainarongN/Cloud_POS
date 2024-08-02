import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/cancel_tran_page.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/close_session.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/holdBill.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/member.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Drawer drawerWidget(BuildContext context) {
  var menuRead = context.read<MenuProvider>();
  var menuWatch = context.watch<MenuProvider>();
  double textSize = Constants().screenWidth(context) * Constants.normalSize;
  return Drawer(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.015),
      child: Container(
        margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.05),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Text(LocaleKeys.menu.tr(),
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: Constants().screenheight(context) * 0.01),
            ListTile(
              title: AppTextStyle()
                  .textNormal('Cancel Transaction', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                openConfCancel(context, menuRead, menuWatch);
              },
            ),
            ListTile(
              title: AppTextStyle().textNormal('Hold Bill', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                openHoldBillDialog(context, menuRead);
              },
            ),
            ListTile(
              title:
                  AppTextStyle().textNormal('Hold Bill Search', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                var homeRead = context.read<HomeProvider>();
                DialogStyle().dialogLoadding(context);
                homeRead.holdBillSearch(context).then((value) {
                  if (homeRead.apisState == ApiState.COMPLETED) {
                    Navigator.maybePop(context).then((value) =>
                        Navigator.pushNamed(context, '/holdBillSearchPage'));
                  }
                });
              },
            ),
            ListTile(
              title: AppTextStyle().textNormal('Member', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                DialogStyle().dialogLoadding(context);
                menuRead.orderSummary(context).then((value) {
                  if (menuWatch.apiState == ApiState.COMPLETED) {
                    Navigator.pop(context);
                    if (menuWatch.transactionModel!.responseObj!.tranData!
                            .memberID ==
                        0) {
                      openNumberMemberDialog(context, menuWatch, menuRead);
                    } else {
                      menuRead
                          .memberData(
                              context,
                              menuWatch
                                  .transactionModel!.responseObj!.memberMobile!)
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
            ),
            ListTile(
              title: AppTextStyle().textNormal('Employee', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Clone bill', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: AppTextStyle().textBold('Close Session', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                var utilityPvd =
                    Provider.of<UtilityProvider>(context, listen: false);
                openAmountSessionDialog(context, utilityPvd, utilityPvd, true);
              },
            ),
            ListTile(
              title: AppTextStyle().textBold('End Day', size: textSize),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                var utilityPvd =
                    Provider.of<UtilityProvider>(context, listen: false);
                openAmountSessionDialog(context, utilityPvd, utilityPvd, false);
              },
            ),
            ListTile(
              title: AppTextStyle()
                  .textBold(LocaleKeys.log_off.tr(), size: textSize),
              leading: const Icon(Icons.power_settings_new),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginPage', (route) => false);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
