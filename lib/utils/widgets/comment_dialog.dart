import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class CommentDialog {
  CommentDialog._internal();
  static final CommentDialog _instance = CommentDialog._internal();
  factory CommentDialog() => _instance;

  Future<void> dialog(BuildContext context, Function()? onPressed,
      {String? frag}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Comment',
            style: TextStyle(
                fontSize: deviceType == 'tablet'
                    ? Constants().screenWidth(context) * 0.02
                    : Constants().screenWidth(context) * Constants.boldSizeMB,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Consumer<MenuProvider>(builder: (context, menuPvd, child) {
              List checkCommentRemark = menuPvd
                  .productObjModel!.responseObj!.productData!.comments!
                  .where((element) => element.groupID == -1)
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: AppTextStyle().textBold(
                        menuPvd.productObjModel!.responseObj!.productData!
                            .productName!,
                        size: deviceType == 'tablet'
                            ? Constants().screenWidth(context) * 0.015
                            : Constants().screenWidth(context) *
                                Constants.boldSizeMB),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        menuPvd.productObjModel!.responseObj!.productData!
                            .commentGroup!.length, (indexCommentGroup) {
                      List checkEmptyCommentGroup = menuPvd
                          .productObjModel!.responseObj!.productData!.comments!
                          .where((element) =>
                              element.groupID ==
                              menuPvd.productObjModel!.responseObj!.productData!
                                  .commentGroup![indexCommentGroup].groupID)
                          .toList();
                      return checkEmptyCommentGroup.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Divider(),
                                AppTextStyle().textBold(
                                    menuPvd
                                        .productObjModel!
                                        .responseObj!
                                        .productData!
                                        .commentGroup![indexCommentGroup]
                                        .groupName!,
                                    size: deviceType == 'tablet'
                                        ? Constants().screenWidth(context) *
                                            0.015
                                        : Constants().screenWidth(context) *
                                            Constants.boldSizeMB),
                                manageSelectComment(menuPvd, indexCommentGroup,
                                    deviceType, context),
                              ],
                            );
                    }),
                  ),
                  const Divider(),
                  checkCommentRemark.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          width: deviceType == 'tablet'
                              ? null
                              : Constants().screenWidth(context),
                          child: TextField(
                            // controller: menuPvd.remarkOrderController,
                            onChanged: (value) {
                              menuPvd.setRemarkComment(value);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelText: 'หมายเหตุ',
                              border:
                                  Constants().myinputborder(), //normal border
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
              );
            }),
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
                  if (frag == 'edit') {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/shopingCartPage'));
                  } else {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/menuPage'));
                  }
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

  Column manageSelectComment(MenuProvider menuPvd, int indexCommentGroup,
      String deviceType, BuildContext context) {
    bool isNotMulti = menuPvd.productObjModel!.responseObj!.productData!
            .commentGroup![indexCommentGroup].isMulti ==
        0;
    int? commentGroupId = menuPvd.productObjModel!.responseObj!.productData!
        .commentGroup![indexCommentGroup].groupID;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          menuPvd.productObjModel!.responseObj!.productData!.comments!.length,
          (index) => menuPvd.productObjModel!.responseObj!.productData!
                      .comments![index].groupID ==
                  commentGroupId
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      isNotMulti
                          ? Radio(
                              value: 1,
                              groupValue: menuPvd.productObjModel!.responseObj!
                                  .productData!.comments![index].qty,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                menuPvd.setSelectComment(
                                    context, indexCommentGroup, index, true);
                              },
                            )
                          : Checkbox(
                              value: menuPvd.productObjModel!.responseObj!
                                          .productData!.comments![index].qty ==
                                      0
                                  ? false
                                  : true,
                              onChanged: (bool? newValue) {
                                menuPvd.setSelectComment(context,
                                    indexCommentGroup, index, newValue!);
                              },
                            ),
                      Expanded(
                        flex: 2,
                        child: AppTextStyle().textNormal(
                            menuPvd.productObjModel!.responseObj!.productData!
                                .comments![index].productName!,
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
                              menuPvd.productObjModel!.responseObj!.productData!
                                  .comments![index].pricePerUnit!
                                  .toString(),
                              size: deviceType == 'tablet'
                                  ? Constants().screenWidth(context) * 0.015
                                  : Constants().screenWidth(context) *
                                      Constants.normalSizeMB),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
    );
  }
}
