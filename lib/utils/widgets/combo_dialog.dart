import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                : Constants().screenWidth(context) * Constants.boldSizeMB,
          ),
          content: Consumer<MenuProvider>(
            builder: (context, menuPvd, child) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: AppTextStyle().textBold(
                        menuPvd.productObjModel!.responseObj!.comboData!
                            .productParentName!,
                        size: deviceType == 'tablet'
                            ? Constants().screenWidth(context) * 0.015
                            : Constants().screenWidth(context) *
                                Constants.boldSizeMB),
                  ),
                  Column(
                    children: List.generate(
                      menuPvd.productObjModel!.responseObj!.comboData!.group!
                          .length,
                      (indexGroup) => menuPvd.productObjModel!.responseObj!
                              .comboData!.group![indexGroup].itemList!.isEmpty
                          ? const SizedBox.shrink()
                          : groupListWidget(
                              menuPvd, indexGroup, deviceType, context),
                    ),
                  ),
                ],
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
                if (deviceType == 'tablet') {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/menuPage'));
                } else {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/shopingCartPage'));
                }
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
        Row(
          children: [
            Container(
              child: AppTextStyle().textBold(
                  menuPvd.productObjModel!.responseObj!.comboData!
                      .group![indexGroup].groupName!,
                  size: deviceType == 'tablet'
                      ? Constants().screenWidth(context) * 0.018
                      : Constants().screenWidth(context) *
                          Constants.normalSizeMB),
            ),
            Container(
              child: AppTextStyle().textBold(
                  ' ( Select ${menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup].requireQty!.toInt()} options )',
                  size: deviceType == 'tablet'
                      ? Constants().screenWidth(context) * 0.018
                      : Constants().screenWidth(context) *
                          Constants.normalSizeMB,
                  color: Constants.primaryColor),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
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
    bool qtyValue = menuPvd.productObjModel!.responseObj!.comboData!
            .group![indexGroup].itemList![indexitemList].qtyValue ==
        0;
    List checkCommentRemark = menuPvd.productObjModel!.responseObj!.comboData!
        .group![indexGroup].itemList![indexitemList].comments!
        .where((element) => element.groupID == -1)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Checkbox(
                value: qtyValue ? false : true,
                onChanged: (bool? newValue) {
                  menuPvd.setQtyCombo(
                      newValue!, indexGroup, indexitemList, 0, 0, false);
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: AppTextStyle().textNormal(
                    menuPvd
                        .productObjModel!
                        .responseObj!
                        .comboData!
                        .group![indexGroup]
                        .itemList![indexitemList]
                        .productName!,
                    size: deviceType == 'tablet'
                        ? Constants().screenWidth(context) * 0.015
                        : Constants().screenWidth(context) *
                            Constants.normalSizeMB),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            children: [
              Column(
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
                    return qtyValue
                        ? const SizedBox.shrink()
                        : checkGroupIdEmpty.isEmpty
                            ? const SizedBox.shrink()
                            : commentGroupListWidget(menuPvd, indexCommentGroup,
                                deviceType, context, indexGroup, indexitemList);
                  },
                ),
              ),
              checkCommentRemark.isEmpty || qtyValue
                  ? const SizedBox.shrink()
                  : Container(
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      width: deviceType == 'tablet'
                          ? null
                          : Constants().screenWidth(context),
                      child: TextField(
                        onChanged: (value) {
                          menuPvd.setRemarkComboSet(
                              value, indexGroup, indexitemList);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          labelText: 'หมายเหตุ',
                          border: Constants().myinputborder(), //normal border
                          enabledBorder:
                              Constants().myinputborder(), //enabled border
                          focusedBorder:
                              Constants().myfocusborder(), //focused border
                        ),
                        style: TextStyle(
                            color: Constants.textColor,
                            fontSize:
                                Constants().screenheight(context) * 0.024),
                      ),
                    ),
            ],
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
                : Constants().screenWidth(context) * Constants.normalSizeMB),
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
    bool isNotMulti = menuPvd.productObjModel!.responseObj!.comboData!
            .commentGroup![indexCommentGroup].isMulti ==
        0;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          isNotMulti
              ? Radio(
                  value: 1,
                  groupValue: menuPvd
                      .productObjModel!
                      .responseObj!
                      .comboData!
                      .group![indexGroup]
                      .itemList![indexitemList]
                      .comments![indexComment]
                      .qty,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    menuPvd.setQtyCombo(true, indexGroup, indexitemList,
                        indexCommentGroup, indexComment, true);
                  },
                )
              : Checkbox(
                  value: checkCommentQty ? false : true,
                  onChanged: (bool? newValue) {
                    menuPvd.setQtyCombo(newValue!, indexGroup, indexitemList,
                        indexCommentGroup, indexComment, true);
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
                    : Constants().screenWidth(context) *
                        Constants.normalSizeMB),
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
                          Constants.normalSizeMB),
            ),
          ),
        ],
      ),
    );
  }
}
