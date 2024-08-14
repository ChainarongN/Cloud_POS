import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Row footbarMobile(BuildContext context, LoginProvider loginWatch) {
  // var configPvd = Provider.of<ConfigProvider>(context, listen: false);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      AppTextStyle().textNormal(
          '${LocaleKeys.device_key.tr()} : ${loginWatch.deviceController.text}',
          size: Constants().fontSizeMB(context, Constants.descSizeMB)),
      const Spacer(),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/configPage');
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  bottom: Constants().screenheight(context) * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Constants.secondaryColor,
                    Constants.primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Constants.primaryColor,
                      blurRadius: 8,
                      offset: Offset(0, 6)),
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.all(Constants().screenheight(context) * 0.01),
                child: AppTextStyle().textNormal(LocaleKeys.configuration.tr(),
                    size: Constants()
                        .fontSizeMB(context, Constants.normalSizeMB)),
              ),
            ),
          ),
          AppTextStyle().textNormal(
              '${LocaleKeys.version.tr()} : ${loginWatch.versionName}',
              size: Constants().fontSizeMB(context, Constants.descSizeMB)),
        ],
      ),
    ],
  );
}
