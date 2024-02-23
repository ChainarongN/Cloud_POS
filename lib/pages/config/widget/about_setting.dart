import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SingleChildScrollView aboutSetting(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        loadDataSetting(context, configRead, configWatch),
      ],
    ),
  );
}

Container loadDataSetting(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.1,
    width: Constants().screenWidth(context) * 0.66,
    margin: const EdgeInsets.only(top: 15),
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
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextStyle().textNormal(
                LocaleKeys.get_new_data.tr(),
                size: 20,
                color: Colors.white,
              ),
              AppTextStyle().textNormal(LocaleKeys.get_new_data_detail.tr(),
                  size: 16, color: Colors.grey.shade100)
            ],
          ),
          const Spacer(),
          Container(
            width: Constants().screenWidth(context) * 0.15,
            height:Constants().screenheight(context) * 0.065,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Constants.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: configWatch.getNewDataSwitch
                      ? Constants.primaryColor
                      : Colors.grey.shade500,
                  size: 40,
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
        ],
      ),
    ),
  );
}
