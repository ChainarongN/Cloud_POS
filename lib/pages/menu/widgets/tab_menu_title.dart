import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Column tabMenuTitle(BuildContext context, MenuProvider menuWatch) {
  return Column(
    children: [
      TabBar(
        controller: menuWatch.getTabController,
        tabs: <Widget>[
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.mediation_outlined,
                    color: Colors.black, size: 20.0),
                AppTextStyle().textNormal(LocaleKeys.menu.tr(),
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.star, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#1',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.star, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#2',
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.search, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal(LocaleKeys.search.tr(),
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.discount, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal(LocaleKeys.discount.tr(),
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.payment, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal(LocaleKeys.payment.tr(),
                    size: Constants().screenheight(context) * 0.023),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
