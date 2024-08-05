import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class ComboDialog {
  ComboDialog._internal();
  static final ComboDialog _instance = ComboDialog._internal();
  factory ComboDialog() => _instance;

  Future<void> dialog(BuildContext context, Function()? onPressed) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppTextStyle().textBold(
            'Combo set',
            size: deviceType == 'tablet'
                ? Constants().screenWidth(context) * 0.02
                : Constants().screenWidth(context) * Constants.boldSize,
          ),
          content: Consumer<MenuProvider>(
            builder: (context, menuPvd, child) => SingleChildScrollView(
              child: Column(
                children: List.generate(
                  menuPvd
                      .productObjModel!.responseObj!.comboData!.group!.length,
                  (indexGroup) => menuPvd.productObjModel!.responseObj!
                          .comboData!.group![indexGroup].itemList!.isEmpty
                      ? const SizedBox.shrink()
                      : groupListWidget(
                          menuPvd, indexGroup, deviceType, context),
                ),
              ),
            ),
          ),
          actions: [
            IconsButton(
              onPressed: onPressed!,
              text: LocaleKeys.ok.tr(),
              color: Constants.primaryColor,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
            IconsButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/menuPage'));
              },
              text: LocaleKeys.cancel.tr(),
              color: Colors.red.shade400,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  Column groupListWidget(MenuProvider menuPvd, int indexGroup,
      String deviceType, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        AppTextStyle().textBold(
            menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup]
                .groupName!,
            size: deviceType == 'tablet'
                ? Constants().screenWidth(context) * 0.018
                : Constants().screenWidth(context) * Constants.normalSize),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              menuPvd.productObjModel!.responseObj!.comboData!
                  .group![indexGroup].itemList!.length,
              (indexitemList) => itemListWidget(
                  menuPvd, indexGroup, indexitemList, deviceType, context),
            ),
          ),
        )
      ],
    );
  }

  Column itemListWidget(MenuProvider menuPvd, int indexGroup, int indexitemList,
      String deviceType, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: AppTextStyle().textNormal(
              menuPvd.productObjModel!.responseObj!.comboData!
                  .group![indexGroup].itemList![indexitemList].productName!,
              size: deviceType == 'tablet'
                  ? Constants().screenWidth(context) * 0.015
                  : Constants().screenWidth(context) * Constants.normalSize),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            children: List.generate(
              menuPvd.productObjModel!.responseObj!.comboData!.commentGroup!
                  .length,
              (indexCommentGroup) {
                List checkGroupIdEmpty = menuPvd
                    .productObjModel!
                    .responseObj!
                    .comboData!
                    .group![indexGroup]
                    .itemList![indexitemList]
                    .comments!
                    .where((element) =>
                        element.groupID ==
                        menuPvd.productObjModel!.responseObj!.comboData!
                            .commentGroup![indexCommentGroup].groupID)
                    .toList();
                return checkGroupIdEmpty.isEmpty
                    ? const SizedBox.shrink()
                    : commentGroupListWidget(menuPvd, indexCommentGroup,
                        deviceType, context, indexGroup, indexitemList);
              },
            ),
          ),
        )
      ],
    );
  }

  Column commentGroupListWidget(
      MenuProvider menuPvd,
      int indexCommentGroup,
      String deviceType,
      BuildContext context,
      int indexGroup,
      int indexitemList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle().textBold(
            menuPvd.productObjModel!.responseObj!.comboData!
                .commentGroup![indexCommentGroup].groupName!,
            size: deviceType == 'tablet'
                ? Constants().screenWidth(context) * 0.015
                : Constants().screenWidth(context) * Constants.normalSize),
        Column(
          children: List.generate(
              menuPvd.productObjModel!.responseObj!.comboData!
                  .group![indexGroup].itemList![indexitemList].comments!.length,
              (indexComment) => menuPvd.productObjModel!.responseObj!.comboData!
                          .commentGroup![indexCommentGroup].groupID ==
                      menuPvd
                          .productObjModel!
                          .responseObj!
                          .comboData!
                          .group![indexGroup]
                          .itemList![indexitemList]
                          .comments![indexComment]
                          .groupID
                  ? commentListWidget(menuPvd, indexGroup, indexitemList,
                      indexComment, indexCommentGroup, deviceType, context)
                  : const SizedBox.shrink()),
        )
      ],
    );
  }

  Container commentListWidget(
      MenuProvider menuPvd,
      int indexGroup,
      int indexitemList,
      int indexComment,
      int indexCommentGroup,
      String deviceType,
      BuildContext context) {
    bool checkCommentQty = menuPvd
            .productObjModel!
            .responseObj!
            .comboData!
            .group![indexGroup]
            .itemList![indexitemList]
            .comments![indexComment]
            .qty ==
        0;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Checkbox(
            value: checkCommentQty ? false : true,
            onChanged: (bool? newValue) {
              menuPvd.setQtyCombo(newValue!, indexGroup, indexitemList,
                  indexCommentGroup, indexComment);
            },
          ),
          Expanded(
            flex: 2,
            child: AppTextStyle().textNormal(
                menuPvd
                    .productObjModel!
                    .responseObj!
                    .comboData!
                    .group![indexGroup]
                    .itemList![indexitemList]
                    .comments![indexComment]
                    .productName!,
                size: deviceType == 'tablet'
                    ? Constants().screenWidth(context) * 0.015
                    : Constants().screenWidth(context) * Constants.normalSize),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: AppTextStyle().textNormal(
                  menuPvd
                      .productObjModel!
                      .responseObj!
                      .comboData!
                      .group![indexGroup]
                      .itemList![indexitemList]
                      .comments![indexComment]
                      .pricePerUnit!
                      .toString(),
                  size: deviceType == 'tablet'
                      ? Constants().screenWidth(context) * 0.015
                      : Constants().screenWidth(context) *
                          Constants.normalSize),
            ),
          ),
        ],
      ),
    );
  }
}
