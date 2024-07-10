import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/cancel_tran_page.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> changeSaleModeDialog(BuildContext context, HomeProvider homeWatch,
    HomeProvider homeRead, MenuProvider menuRead) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.6,
          width: Constants().screenWidth(context) * 0.6,
          child: Padding(
            padding: EdgeInsets.all(Constants().screenWidth(context) * 0.01),
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(
                  homeWatch.saleModeDataList!.length,
                  (index) => GestureDetector(
                        onTap: () {
                          confChangeDialog(context, menuRead, index);
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenWidth(context) * 0.03),
                            child: Center(
                              child: AppTextStyle().textNormal(
                                  homeWatch
                                      .saleModeDataList![index].saleModeName!,
                                  size: Constants().screenWidth(context) *
                                      Constants.boldSize),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> confChangeDialog(
    BuildContext context, MenuProvider menuRead, int saleModeIndex) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.14,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  openConfCancel(context, menuRead,
                      indexSaleMode: saleModeIndex);
                },
                child: Center(
                  child: AppTextStyle().textBold('Cancel Transaction',
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                ),
              ),
              SizedBox(height: Constants().screenheight(context) * 0.01),
              ElevatedButton(
                onPressed: () {
                  LoadingStyle().dialogLoadding(context);
                  menuRead.holdBill(context).then((value) async {
                    if (menuRead.apiState == ApiState.COMPLETED) {
                      var homePvd = context.read<HomeProvider>();
                      await homePvd
                          .openTransaction(context, index: saleModeIndex)
                          .then((value) {
                        if (homePvd.apisState == ApiState.COMPLETED) {
                          menuRead
                              .setTranData(
                                  tranModel: json.encode(homePvd.openTranModel))
                              .then((value) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/menuPage', (route) => false);
                          });
                        }
                      });
                    }
                  });
                },
                child: Center(
                  child: AppTextStyle().textBold('Hold Bill',
                      size: Constants().screenWidth(context) *
                          Constants.normalSize),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.close.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize,
                color: Colors.grey),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
