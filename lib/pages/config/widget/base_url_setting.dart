import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

SingleChildScrollView baseUrlSetting(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        baseUrlConfig(context),
        detailBrand(context),
        saveConfigBtn(context),
      ],
    ),
  );
}

Column detailBrand(BuildContext context) {
  return Column(
    children: <Widget>[
      const SizedBox(height: 10),
      cardDetail(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle()
                    .textBold(LocaleKeys.merchant_name.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.brand_name.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
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
                AppTextStyle().textBold(LocaleKeys.shop_name.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.shop_key.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
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
                AppTextStyle().textBold(LocaleKeys.pos_name.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle().textBold(LocaleKeys.device_key.tr(), size: 18),
                AppTextStyle().textNormal('6102-1234-5678-1234', size: 18),
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
                AppTextStyle()
                    .textBold(LocaleKeys.store_address.tr(), size: 18),
                AppTextStyle().textNormal('-', size: 18),
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
            margin: const EdgeInsets.only(left: 20, right: 25),
            child: widget,
          ),
        ],
      ),
    ),
  );
}

Container saveConfigBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: Constants().screenheight(context) * 0.09,
    width: Constants().screenWidth(context) * 0.45,
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
            offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              )),
          AppTextStyle().textNormal(LocaleKeys.save_config.tr(),
              size: 20, color: Colors.white),
        ],
      ),
    ),
  );
}

Column baseUrlConfig(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 20),
        width: Constants().screenWidth(context) * 0.6,
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100.withOpacity(0.1),
              labelText: "Platform API Base Url",
              border: Constants().myinputborder(),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Icon(
                  Icons.cloud_outlined,
                  size: 40,
                ),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.cancel),
              )),
          style: const TextStyle(color: Constants.textColor, fontSize: 20),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: Constants().screenheight(context) * 0.09,
        width: Constants().screenWidth(context) * 0.45,
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
                offset: Offset(0, 6)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: const Icon(
                    Icons.cloud_done_outlined,
                    size: 40,
                    color: Colors.white,
                  )),
              AppTextStyle().textNormal(LocaleKeys.get_shop_data.tr(),
                  size: 20, color: Colors.white),
            ],
          ),
        ),
      ),
    ],
  );
}
