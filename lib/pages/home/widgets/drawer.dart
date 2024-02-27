import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
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
            Text('Menu',
                style: TextStyle(
                    fontSize: Constants().screenheight(context) * 0.01,
                    color: Colors.black26)),
            SizedBox(height: Constants().screenheight(context) * 0.01),
            ListTile(
              title: AppTextStyle().textNormal(
                'Working Time',
              ),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Out of Stock'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Reports'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Utility'),
              leading: const Icon(Icons.build),
              onTap: () {
                Navigator.pushNamed(context, '/utilityPage');
              },
            ),
            ListTile(
              title: AppTextStyle().textNormal('News'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Sync : 7'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: AppTextStyle().textNormal('Switch User'),
              leading: Icon(Icons.access_alarm),
              onTap: () {},
            ),
            ListTile(
              title: AppTextStyle().textNormal('Log Off'),
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
