import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Row footbar(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      AppTextStyle().textNormal(
          '${LocaleKeys.device_key.tr()} : 6102-3452-2456-1234',
          size: Constants().screenheight(context) * 0.023),
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
                  bottom: Constants().screenheight(context) * 0.023),
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
                    EdgeInsets.all(Constants().screenheight(context) * 0.015),
                child: AppTextStyle().textNormal(LocaleKeys.configuration.tr(),
                    size: Constants().screenheight(context) * 0.023),
              ),
            ),
          ),
          AppTextStyle().textNormal('${LocaleKeys.version.tr()} : 0.0.19',
              size: Constants().screenheight(context) * 0.023),
        ],
      ),
    ],
  );
}
