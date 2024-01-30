import 'package:cloud_pos/pages/config/widget/about_setting.dart';
import 'package:cloud_pos/pages/config/widget/base_url_setting.dart';
import 'package:cloud_pos/pages/config/widget/menu_config.dart';
import 'package:cloud_pos/pages/config/widget/printer_setting.dart';
import 'package:cloud_pos/providers/config_provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConfigProvider>().init();
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuConfig(context, configRead, configWatch),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: const VerticalDivider(thickness: 2),
              ),
              Consumer<ConfigProvider>(builder: (context, data, child) {
                Widget widget = baseUrlSetting(context);
                switch (data.getWidgetString) {
                  case 'baseUrl':
                    widget = baseUrlSetting(context);
                    break;
                  case 'printer':
                    widget = printerSetting(context, configRead, configWatch);
                    break;
                  case 'about':
                    widget = aboutSetting(context, configRead, configWatch);
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
