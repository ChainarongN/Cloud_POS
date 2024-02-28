import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.015),
      child: Container(
        margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.05),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Constants.primaryColor,
              ),
              child: Text('Drawer Header'),
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
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.out_of_stock.tr()),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.reports.tr()),
              leading: Icon(Icons.access_alarm),
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
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('${LocaleKeys.sync.tr()} : 7'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.switch_user.tr()),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal(LocaleKeys.log_off.tr()),
              leading: Icon(Icons.power_settings_new),
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
