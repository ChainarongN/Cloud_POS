import 'package:cloud_pos/pages/config/mobile/widget/base_url_setting_mobile.dart';
import 'package:cloud_pos/pages/config/mobile/widget/other_setting_mobile.dart';
import 'package:cloud_pos/pages/config/mobile/widget/printer_setting_mobile.dart';
import 'package:cloud_pos/providers/config/config_provider.dart';

import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ConfigMobile extends StatelessWidget {
  const ConfigMobile({super.key});

  @override
  Widget build(BuildContext context) {
    var configRead = context.read<ConfigProvider>();
    var configWatch = context.watch<ConfigProvider>();
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: AppTextStyle().textNormal('vTec - Cloud POS Configuration'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Base Url ',
              ),
              Tab(
                text: 'Printer ',
              ),
              // Tab(
              //   text: 'Licenes info',
              // ),
              Tab(
                text: 'Other',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: baseUrlSettingMobile(context, configWatch, configRead),
            ),
            Container(
              child: printerSettingMobile(context, configRead, configWatch),
            ),
            // Center(
            //   child: Text("It's sunny here"),
            // ),
            Container(
              child: otherSettingMobile(context, configRead, configWatch),
            ),
          ],
        ),
      ),
    );
  }
}
