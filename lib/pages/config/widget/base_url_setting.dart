import 'package:cloud_pos/providers/config/config_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SingleChildScrollView baseUrlSetting(BuildContext context,
    ConfigProvider configWatch, ConfigProvider configRead) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        baseUrlConfig(context, configWatch),
        detailBrand(context, configWatch),
        saveConfigBtn(context, configRead),
      ],
    ),
  );
}

Column detailBrand(BuildContext context, ConfigProvider configWatch) {
  return Column(
    children: <Widget>[
      SizedBox(height: Constants().screenheight(context) * 0.015),
      cardDetail(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.merchant_name.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.brand_name.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
          ],
        ),
      ),
      cardDetail(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.shop_name.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.shop_key.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
          ],
        ),
      ),
      cardDetail(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.pos_name.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.device_key.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal(configWatch.deviceIdController.text,
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
          ],
        ),
      ),
      cardDetail(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.store_address.tr(),
                    size: Constants().screenheight(context) * 0.025),
                AppTextStyle().textNormal('-',
                    size: Constants().screenheight(context) * 0.025),
              ],
            ),
          ],
        ),
      )
    ],
  );
}

Widget cardDetail(BuildContext context, Widget widget) {
  return SizedBox(
    width: Constants().screenWidth(context) * 0.6,
    height: Constants().screenheight(context) * 0.15,
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: Constants().screenheight(context) * 0.025,
                right: Constants().screenheight(context) * 0.025),
            child: widget,
          ),
        ],
      ),
    ),
  );
}

GestureDetector saveConfigBtn(BuildContext context, ConfigProvider configRead) {
  return GestureDetector(
    onTap: () {
      configRead.saveConfig().then((value) {
        LoadingStyle().dialogSuccess(context, isPopUntil: false);
      });
    },
    child: Container(
      alignment: Alignment.center,
      height: Constants().screenheight(context) * 0.09,
      width: Constants().screenWidth(context) * 0.45,
      margin: EdgeInsets.only(
          top: Constants().screenheight(context) * 0.02,
          bottom: Constants().screenheight(context) * 0.02),
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
              offset: Offset(0, 6)),
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
                  size: Constants().screenheight(context) * 0.055,
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

Column baseUrlConfig(BuildContext context, ConfigProvider configWatch) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.023),
        width: Constants().screenWidth(context) * 0.6,
        child: TextField(
          controller: configWatch.baseUrlController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100.withOpacity(0.1),
              labelText: "Platform API Base Url",
              border: Constants().myinputborder(),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                    left: Constants().screenheight(context) * 0.04,
                    right: Constants().screenheight(context) * 0.04),
                child: GestureDetector(
                  onLongPress: () {
                    configWatch.setBaseUrlForTest();
                  },
                  child: Icon(
                    Icons.cloud_outlined,
                    size: Constants().screenheight(context) * 0.05,
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                    right: Constants().screenheight(context) * 0.02),
                child: const Icon(Icons.cancel),
              )),
          style: TextStyle(
              color: Constants.textColor,
              fontSize: Constants().screenheight(context) * 0.03),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: Constants().screenheight(context) * 0.09,
        width: Constants().screenWidth(context) * 0.45,
        margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.02),
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
                offset: Offset(0, 6)),
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
                    Icons.cloud_done_outlined,
                    size: Constants().screenheight(context) * 0.055,
                    color: Colors.white,
                  )),
              AppTextStyle().textNormal(LocaleKeys.get_shop_data.tr(),
                  size: Constants().screenheight(context) * 0.03,
                  color: Colors.white),
            ],
          ),
        ),
      ),
    ],
  );
}
