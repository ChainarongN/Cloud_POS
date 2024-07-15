import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Drawer drawer(
    BuildContext context, HomeProvider homeWatch, HomeProvider homeRead) {
  return Drawer(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.015),
      child: Container(
        margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.05),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
              ),
              child: Consumer<LoginProvider>(
                builder: (context, loginPvd, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${LocaleKeys.staff_ID.tr()} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${loginPvd.loginModel!.responseObj!.staffInfo!.staffID}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${LocaleKeys.gender.tr()} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${loginPvd.loginModel!.responseObj!.staffInfo!.staffGender}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${LocaleKeys.role.tr()} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${loginPvd.loginModel!.responseObj!.staffInfo!.staffRoleName}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${LocaleKeys.first_name.tr()} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${loginPvd.loginModel!.responseObj!.staffInfo!.staffFirstName}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${LocaleKeys.last_name.tr()} : ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${loginPvd.loginModel!.responseObj!.staffInfo!.staffLastName}')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(LocaleKeys.menu.tr(),
                style: TextStyle(
                    fontSize: Constants().screenheight(context) * 0.02,
                    color: Colors.black26)),
            SizedBox(height: Constants().screenheight(context) * 0.01),
            ListTile(
              title: AppTextStyle().textNormal(
                LocaleKeys.working_time.tr(),
              ),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.out_of_stock.tr()),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.reports.tr()),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.utility.tr()),
              leading: const Icon(Icons.build),
              onTap: () {
                Navigator.pushNamed(context, '/utilityPage');
              },
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.news.tr()),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('${LocaleKeys.sync.tr()} : 7'),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Hold Bill Search'),
              leading: const Icon(Icons.access_alarm),
              onTap: () {
                DialogStyle().dialogLoadding(context);
                homeRead.holdBillSearch(context).then((value) {
                  if (homeWatch.apisState == ApiState.COMPLETED) {
                    holdBillDialog(context, homeWatch, homeRead);
                  }
                });
              },
            ),
            const Divider(),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.switch_user.tr()),
              leading: const Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.log_off.tr()),
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

Future<void> holdBillDialog(
    BuildContext context, HomeProvider homeWatch, HomeProvider homeRead) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      var menuProvider = Provider.of<MenuProvider>(context, listen: false);
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.7,
          width: Constants().screenWidth(context) * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: AppTextStyle().textBold('Hold Bill List',
                      size: Constants().screenWidth(context) * 0.015),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: homeWatch.holdBillSearchModel!.responseObj!.isEmpty
                      ? Center(
                          child: AppTextStyle().textNormal('No information'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: homeWatch
                              .holdBillSearchModel!.responseObj!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                await homeRead.unHoldBill(
                                    context,
                                    homeWatch.holdBillSearchModel!
                                        .responseObj![index].orderId!);
                                if (homeWatch.apisState == ApiState.COMPLETED) {
                                  Navigator.of(context).popUntil(
                                      ModalRoute.withName("/homePage"));
                                  menuProvider
                                      .setTranData(
                                          tranModel: json
                                              .encode(homeWatch.openTranModel))
                                      .then((value) {
                                    Navigator.pushNamed(context, '/menuPage');
                                  });
                                }
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    Constants().screenWidth(context) * 0.02,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: Constants()
                                                    .screenWidth(context) *
                                                0.03),
                                        child: AppTextStyle().textNormal(
                                            homeWatch
                                                .holdBillSearchModel!
                                                .responseObj![index]
                                                .saleModeName!,
                                            size: Constants()
                                                    .screenWidth(context) *
                                                0.013),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: Constants()
                                                    .screenWidth(context) *
                                                0.03),
                                        child: AppTextStyle().textNormal(
                                            homeWatch
                                                .holdBillSearchModel!
                                                .responseObj![index]
                                                .customerName!,
                                            size: Constants()
                                                    .screenWidth(context) *
                                                0.013),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: Constants()
                                                    .screenWidth(context) *
                                                0.03),
                                        child: AppTextStyle().textNormal(
                                            homeWatch
                                                .holdBillSearchModel!
                                                .responseObj![index]
                                                .customerMobile!,
                                            size: Constants()
                                                    .screenWidth(context) *
                                                0.013),
                                      ),
                                      Container(
                                        child: AppTextStyle().textNormal(
                                            homeWatch.holdBillSearchModel!
                                                .responseObj![index].openTime!,
                                            size: Constants()
                                                    .screenWidth(context) *
                                                0.013),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: 18, color: Colors.red),
            onPressed: () async {
              Navigator.of(context).popUntil(ModalRoute.withName("/homePage"));
            },
          ),
        ],
      );
    },
  );
}
