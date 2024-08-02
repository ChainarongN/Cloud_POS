import 'dart:typed_data';
import 'package:cloud_pos/providers/config/config_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:screenshot/screenshot.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pdf;
// import 'package:image/image.dart' as im;

SingleChildScrollView printerSettingMobile(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        receiptPrinter(context, configRead, configWatch),
        printerModel(context, configRead, configWatch),
        connectionType(context, configRead, configWatch),
        configWatch.getConnectionTypeValue == 'SunmiV2'
            ? const SizedBox.shrink()
            : printerAddress(context, configWatch, configRead),
        testPrintBtn(context, configRead, configWatch),
        btnSave(context, configWatch, configRead),
        // Container(
        //   margin: const EdgeInsets.only(top: 40),
        //   child: Screenshot(
        //     controller: configWatch.getScreenShotController,
        //     child: HtmlWidget(Printer().htmlTest),
        //   ),
        // ),
      ],
    ),
  );
}

GestureDetector testPrintBtn(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return GestureDetector(
    onTap: () async {
      // configWatch.getScreenShotController
      //     .capture(delay: const Duration(seconds: 1), pixelRatio: 1.2)
      //     .then((Uint8List? value) async {
      //   Printer().printer(value!);
      // });
      Printer().testPrinter();
      // Constants().printInfo('aaaaaaaaaaaaaa');
    },
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.06,
      width: Constants().screenWidth(context) * 0.65,
      margin: EdgeInsets.only(
        top: Constants().screenheight(context) * 0.01,
        left: Constants().screenWidth(context) * 0.015,
      ),
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
                    right: Constants().screenheight(context) * 0.01),
                child: Icon(
                  Icons.print,
                  size: Constants().screenWidth(context) * 0.025,
                  color: Colors.white,
                )),
            AppTextStyle().textNormal(LocaleKeys.test_print.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize,
                color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

GestureDetector btnSave(BuildContext context, ConfigProvider configWatch,
    ConfigProvider configRead) {
  return GestureDetector(
    onTap: () async {
      configRead.saveConfigPrinter().then((value) {
        DialogStyle().dialogSuccess(context, isPopUntil: false);
      });
    },
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.06,
      width: Constants().screenWidth(context),
      margin: EdgeInsets.only(
        top: Constants().screenheight(context) * 0.03,
        bottom: Constants().screenheight(context) * 0.02,
        left: Constants().screenWidth(context) * 0.1,
        right: Constants().screenWidth(context) * 0.1,
      ),
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
                    right: Constants().screenheight(context) * 0.015),
                child: Icon(
                  Icons.done,
                  size: Constants().screenWidth(context) * 0.05,
                  color: Colors.white,
                )),
            AppTextStyle().textNormal(LocaleKeys.save_config.tr(),
                size: Constants().screenWidth(context) * Constants.boldSize,
                color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

SizedBox printerAddress(BuildContext context, ConfigProvider configWatch,
    ConfigProvider configRead) {
  return SizedBox(
    width: Constants().screenWidth(context),
    height: Constants().screenheight(context) * 0.15,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.035,
          right: Constants().screenheight(context) * 0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.ip_printer.tr()} : ',
              size: Constants().screenWidth(context) * Constants.boldSize),
          Container(
            margin: EdgeInsets.only(
              top: Constants().screenheight(context) * 0.01,
            ),
            width: Constants().screenWidth(context),
            // height: Constants().screenWidth(context) * 0.1,
            child: TextField(
              controller: configWatch.addressController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100.withOpacity(0.1),
                  labelText: LocaleKeys.ip_printer.tr(),
                  border: Constants().myinputborder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: Constants().screenWidth(context) * 0.025,
                        right: Constants().screenWidth(context) * 0.02),
                    child: GestureDetector(
                      onLongPress: () {
                        configWatch.setAddressForTest();
                      },
                      child: Icon(
                        Icons.wifi_password,
                        size: Constants().screenWidth(context) * 0.05,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                        right: Constants().screenWidth(context) * 0.015),
                    child: const Icon(Icons.cancel),
                  )),
              style: TextStyle(
                  color: Constants.textColor,
                  fontSize:
                      Constants().screenWidth(context) * Constants.normalSize),
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
    width: Constants().screenWidth(context),
    height: Constants().screenheight(context) * 0.13,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.035,
          right: Constants().screenheight(context) * 0.035),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.connection_type.tr()} : ',
              size: Constants().screenWidth(context) * Constants.boldSize),
          const Spacer(),
          SizedBox(
            width: Constants().screenWidth(context) * 0.4,
            child: dropdownButton(context,
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getConnectList,
                value: configWatch.getConnectionTypeValue, onChanged: (value) {
              configRead.setConnectionValue(value!);
              Constants().printWarning(configWatch.getConnectionTypeValue);
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
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
    width: Constants().screenWidth(context),
    height: Constants().screenheight(context) * 0.13,
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.035,
          right: Constants().screenheight(context) * 0.035),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('${LocaleKeys.printer_model.tr()} : ',
              size: Constants().screenWidth(context) * Constants.boldSize),
          const Spacer(),
          SizedBox(
            width: Constants().screenWidth(context) * 0.4,
            child: dropdownButton(context,
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getPrinterList,
                value: configWatch.getPrintModelValue, onChanged: (value) {
              configRead.setPrinterValue(value!);
              Constants().printWarning(configWatch.getPrintModelValue);
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
                  fontSize:
                      Constants().screenWidth(context) * Constants.normalSize,
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
    height: Constants().screenheight(context) * 0.06,
    width: Constants().screenWidth(context),
    margin: EdgeInsets.only(
      top: Constants().screenheight(context) * 0.025,
      left: Constants().screenWidth(context) * 0.015,
      right: Constants().screenWidth(context) * 0.015,
    ),
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
          left: Constants().screenWidth(context) * 0.025,
          right: Constants().screenWidth(context) * 0.025),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal(
            LocaleKeys.receipt_printer.tr(),
            size: Constants().screenWidth(context) * Constants.boldSize,
            color: Colors.white,
          ),
          const Spacer(),
          Container(
            width: Constants().screenWidth(context) * 0.4,
            height: Constants().screenheight(context) * 0.05,
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
                  size: Constants().screenWidth(context) * 0.1,
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
