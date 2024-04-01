import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_pos/providers/config_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pdf;
// import 'package:image/image.dart' as im;

SingleChildScrollView printerSetting(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        receiptPrinter(context, configRead, configWatch),
        printerModel(context, configRead, configWatch),
        connectionType(context, configRead, configWatch),
        printerAddress(context),
        testPrintBtn(context, configRead, configWatch),
        btnSave(context, configWatch),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: Screenshot(
            controller: configWatch.getScreenShotController,
            child: HtmlWidget(Printer().htmlTest),
          ),
        ),
      ],
    ),
  );
}

GestureDetector testPrintBtn(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return GestureDetector(
    onTap: () async {
      configWatch.getScreenShotController
          .capture(delay: const Duration(seconds: 1), pixelRatio: 1.2)
          .then((Uint8List? value) async {
        Printer().printer(value!);
      });
    },
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.09,
      width: Constants().screenWidth(context) * 0.32,
      margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade200,
            Colors.blue.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200,
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(
                    right: Constants().screenheight(context) * 0.02),
                child: Icon(
                  Icons.print,
                  size: Constants().screenheight(context) * 0.05,
                  color: Colors.white,
                )),
            AppTextStyle().textNormal(LocaleKeys.test_print.tr(),
                size: Constants().screenheight(context) * 0.027,
                color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

GestureDetector btnSave(BuildContext context, ConfigProvider configWatch) {
  return GestureDetector(
    onTap: () async {},
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.09,
      width: Constants().screenWidth(context) * 0.66,
      margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade200,
            Colors.blue.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200,
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(
                    right: Constants().screenheight(context) * 0.03),
                child: Icon(
                  Icons.done,
                  size: Constants().screenheight(context) * 0.05,
                  color: Colors.white,
                )),
            AppTextStyle().textNormal(LocaleKeys.save_config.tr(),
                size: Constants().screenheight(context) * 0.03,
                color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

SizedBox printerAddress(BuildContext context) {
  return SizedBox(
    width: Constants().screenWidth(context) * 0.66,
    height: Constants().screenheight(context) * 0.13,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.05,
          right: Constants().screenheight(context) * 0.05),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.ip_printer.tr()} : ',
              size: Constants().screenheight(context) * 0.027),
          const Spacer(),
          SizedBox(
            width: Constants().screenWidth(context) * 0.4,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100.withOpacity(0.1),
                  labelText: LocaleKeys.ip_printer.tr(),
                  border: Constants().myinputborder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: Constants().screenheight(context) * 0.04,
                        right: Constants().screenheight(context) * 0.02),
                    child: Icon(
                      Icons.wifi_password,
                      size: Constants().screenheight(context) * 0.045,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                        right: Constants().screenheight(context) * 0.015),
                    child: const Icon(Icons.cancel),
                  )),
              style: TextStyle(
                  color: Constants.textColor,
                  fontSize: Constants().screenheight(context) * 0.025),
            ),
          ),
        ],
      ),
    ),
  );
}

SizedBox connectionType(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return SizedBox(
    width: Constants().screenWidth(context) * 0.5,
    height: Constants().screenheight(context) * 0.13,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.05,
          right: Constants().screenheight(context) * 0.05),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.connection_type.tr()} : ',
              size: Constants().screenheight(context) * 0.027),
          const Spacer(),
          SizedBox(
            width: Constants().screenWidth(context) * 0.17,
            child: dropdownButton(context,
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getConnectList,
                value: configWatch.getConnectionValue, onChanged: (value) {
              configRead.setConnectionValue(value!);
              Constants().printWarning(configWatch.getConnectionValue);
            }),
          ),
        ],
      ),
    ),
  );
}

Container printerModel(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    width: Constants().screenWidth(context) * 0.5,
    height: Constants().screenheight(context) * 0.13,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.05,
          right: Constants().screenheight(context) * 0.05),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.printer_model.tr()} : ',
              size: Constants().screenheight(context) * 0.027),
          const Spacer(),
          SizedBox(
            width: Constants().screenWidth(context) * 0.17,
            child: dropdownButton(context,
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getPrinterList,
                value: configWatch.getPrintValue, onChanged: (value) {
              configRead.setPrinterValue(value!);
              Constants().printWarning(configWatch.getPrintValue);
            }),
          ),
        ],
      ),
    ),
  );
}

DropdownButtonFormField2<String> dropdownButton(BuildContext context,
    {ConfigProvider? configWatch,
    ConfigProvider? configRead,
    List<String>? itemMap,
    String? value,
    Function(String?)? onChanged}) {
  return DropdownButtonFormField2<String>(
    isExpanded: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    value: value,
    items: itemMap!
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: Constants().screenheight(context) * 0.025,
                ),
              ),
            ))
        .toList(),
    onChanged: onChanged,
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 8),
    ),
    iconStyleData: const IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}

Container receiptPrinter(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.09,
    width: Constants().screenWidth(context) * 0.66,
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.02),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade200,
          Colors.blue.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade200,
          blurRadius: 8,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.04,
          right: Constants().screenheight(context) * 0.04),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal(
            LocaleKeys.receipt_printer.tr(),
            size: Constants().screenheight(context) * 0.03,
            color: Colors.white,
          ),
          const Spacer(),
          Container(
            width: Constants().screenWidth(context) * 0.15,
            height: Constants().screenheight(context) * 0.065,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Constants.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.print,
                  color: configWatch.getprinterSwitch
                      ? Constants.primaryColor
                      : Colors.grey.shade500,
                  size: Constants().screenheight(context) * 0.05,
                ),
                Switch(
                  value: configWatch.getprinterSwitch,
                  activeColor: Colors.blue.shade600,
                  onChanged: (bool value) {
                    configRead.setPrinterSwitch(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
