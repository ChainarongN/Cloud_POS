import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SingleChildScrollView menuConfig(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            configRead.setWidgetString('baseUrl');
          },
          child: Container(
            alignment: Alignment.center,
            height: Constants().screenheight(context) * 0.09,
            width: Constants().screenWidth(context) * 0.25,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 196, 255),
                  Color.fromARGB(255, 182, 212, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 182, 212, 255),
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AppTextStyle().textNormal(LocaleKeys.base_url_setting.tr(),
                  size: 20, color: Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            configRead.setWidgetString('printer');
          },
          child: Container(
            alignment: Alignment.center,
            height: Constants().screenheight(context) * 0.09,
            width: Constants().screenWidth(context) * 0.25,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 196, 255),
                  Color.fromARGB(255, 182, 212, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 182, 212, 255),
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AppTextStyle().textNormal(LocaleKeys.printer_setting.tr(),
                  size: 20, color: Colors.white),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: Constants().screenheight(context) * 0.09,
          width: Constants().screenWidth(context) * 0.25,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 138, 196, 255),
                Color.fromARGB(255, 182, 212, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 182, 212, 255),
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppTextStyle().textNormal(LocaleKeys.licenes_setting.tr(),
                size: 20, color: Colors.white),
          ),
        ),
        GestureDetector(
          onTap: () {
            configRead.setWidgetString('about');
          },
          child: Container(
            alignment: Alignment.center,
            height: Constants().screenheight(context) * 0.09,
            width: Constants().screenWidth(context) * 0.25,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 196, 255),
                  Color.fromARGB(255, 182, 212, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 182, 212, 255),
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AppTextStyle().textNormal(LocaleKeys.about_setting.tr(),
                  size: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
