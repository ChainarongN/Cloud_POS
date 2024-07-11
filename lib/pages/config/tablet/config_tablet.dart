import 'package:cloud_pos/pages/config/tablet/widget/other_setting_tablet.dart';
import 'package:cloud_pos/pages/config/tablet/widget/base_url_setting_tablet.dart';
import 'package:cloud_pos/pages/config/tablet/widget/menu_config_tablet.dart';
import 'package:cloud_pos/pages/config/tablet/widget/printer_setting_tablet.dart';
import 'package:cloud_pos/providers/config/config_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigTablet extends StatefulWidget {
  const ConfigTablet({super.key});

  @override
  State<ConfigTablet> createState() => _ConfigTabletState();
}

class _ConfigTabletState extends State<ConfigTablet> {
  @override
  void initState() {
    super.initState();
    context.read<ConfigProvider>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    var configRead = context.read<ConfigProvider>();
    var configWatch = context.watch<ConfigProvider>();
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('vTec - Cloud POS Configuration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants().screenheight(context) * 0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuConfigTablet(context, configRead, configWatch),
              Container(
                margin: EdgeInsets.only(
                    left: Constants().screenheight(context) * 0.024,
                    right: Constants().screenheight(context) * 0.024),
                child: const VerticalDivider(thickness: 2),
              ),
              Consumer<ConfigProvider>(builder: (context, data, child) {
                Widget widget =
                    baseUrlSettingTablet(context, configWatch, configRead);
                switch (data.getWidgetString) {
                  case 'baseUrl':
                    widget =
                        baseUrlSettingTablet(context, configWatch, configRead);
                    break;
                  case 'printer':
                    widget =
                        printerSettingTablet(context, configRead, configWatch);
                    break;
                  case 'about':
                    widget =
                        otherSettingTablet(context, configRead, configWatch);
                    break;
                }
                return widget;
              }),
            ],
          ),
        ),
      ),
    );
  }
}
