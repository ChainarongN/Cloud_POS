import 'package:cloud_pos/providers/provider.dart';

import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

SingleChildScrollView otherSettingMobile(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        loadDataSetting(context, configRead, configWatch),
        SizedBox(
          height: Constants().screenheight(context) * 0.13,
          child: Padding(
            padding: EdgeInsets.only(
                left: Constants().screenheight(context) * 0.03,
                right: Constants().screenheight(context) * 0.03),
            child: Row(
              children: <Widget>[
                Container(
                  child: AppTextStyle().textNormal('Device ID : ',
                      size: Constants().screenheight(context) * 0.02),
                ),
                const Spacer(),
                SizedBox(
                  width: Constants().screenWidth(context) * 0.65,
                  child: TextField(
                    controller: configWatch.deviceIdController,
                    maxLength: 19,
                    inputFormatters: [
                      MaskedInputFormatter('####-####-####-####',
                          allowedCharMatcher: RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100.withOpacity(0.1),
                        labelText: 'XXXX-XXXX-XXXX-XXXX',
                        border: Constants().myinputborder(),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: Constants().screenheight(context) * 0.01),
                          child: Icon(
                            Icons.lock,
                            size: Constants().screenheight(context) * 0.02,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: Constants().screenheight(context) * 0.01),
                          child: const Icon(Icons.cancel),
                        )),
                    style: TextStyle(
                        color: Constants.textColor,
                        fontSize: Constants().screenheight(context) * 0.018),
                    onChanged: (value) {
                      if (value.length == 19 || value.isEmpty) {
                        configRead.setDeviceID(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container loadDataSetting(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.07,
    margin: EdgeInsets.only(
        top: Constants().screenheight(context) * 0.015,
        bottom: Constants().screenheight(context) * 0.030,
        left: Constants().screenWidth(context) * 0.015,
        right: Constants().screenWidth(context) * 0.015),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 113, 134, 255),
          Color.fromARGB(255, 157, 198, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 157, 198, 255),
          blurRadius: 8,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(
          left: Constants().screenheight(context) * 0.015,
          right: Constants().screenheight(context) * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextStyle().textBold(
                LocaleKeys.get_new_data.tr(),
                size: Constants().screenheight(context) * 0.02,
                color: Colors.white,
              ),
              AppTextStyle().textNormal(LocaleKeys.get_new_data_detail.tr(),
                  size: Constants().screenheight(context) * 0.016,
                  color: Colors.grey.shade100)
            ],
          ),
          const Spacer(),
          Container(
            width: Constants().screenWidth(context) * 0.25,
            height: Constants().screenheight(context) * 0.055,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Constants.secondaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Constants().screenWidth(context) * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: configWatch.getNewDataSwitch
                        ? Constants.primaryColor
                        : Colors.grey.shade500,
                    size: Constants().screenheight(context) * 0.03,
                  ),
                  Switch(
                    value: configWatch.getNewDataSwitch,
                    activeColor: Colors.blue.shade600,
                    onChanged: (bool value) {
                      configRead.setNewDataSwitch(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
