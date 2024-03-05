import 'package:cloud_pos/providers/login_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Drawer drawer(BuildContext context) {
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
