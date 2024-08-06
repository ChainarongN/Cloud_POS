import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class DialogStyle {
  DialogStyle._internal();
  static final DialogStyle _instance = DialogStyle._internal();
  factory DialogStyle() => _instance;

  Future<void> commentDialog(
      BuildContext context, Function()? onPressed) async {
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
                    : Constants().screenWidth(context) * Constants.boldSize,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Consumer<MenuProvider>(builder: (context, menuPvd, child) {
              List checkCommentRemark = menuPvd
                  .productObjModel!.responseObj!.productData!.comments!
                  .where((element) => element.groupID == -1)
                  .toList();
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      menuPvd.productObjModel!.responseObj!.productData!
                          .commentGroup!.length,
                      (indexCommentGroup) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Divider(),
                          AppTextStyle().textBold(
                              menuPvd.productObjModel!.responseObj!.productData!
                                  .commentGroup![indexCommentGroup].groupName!,
                              size: deviceType == 'tablet'
                                  ? Constants().screenWidth(context) * 0.015
                                  : Constants().screenWidth(context) *
                                      Constants.boldSize),
                          manageSelectComment(
                              menuPvd, indexCommentGroup, deviceType, context),
                        ],
                      ),
                    ),
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
                            controller: menuPvd.remarkOrderController,
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
        ;
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
                                menuPvd.setQtyComment(
                                    indexCommentGroup, index, true);
                              },
                            )
                          : Checkbox(
                              value: menuPvd.productObjModel!.responseObj!
                                          .productData!.comments![index].qty ==
                                      0
                                  ? false
                                  : true,
                              onChanged: (bool? newValue) {
                                menuPvd.setQtyComment(
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
                                    Constants.normalSize),
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
                                      Constants.normalSize),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
    );
  }

  Future<void> dialogPayment2(BuildContext context,
      {String? text, bool? popUntil, String? popToPage}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: TextStyle(
          fontSize: deviceType == 'tablet'
              ? Constants().screenWidth(context) * 0.015
              : Constants().screenWidth(context) * Constants.normalSize,
          fontWeight: FontWeight.bold),
      msgStyle: const TextStyle(fontSize: 18),
      msg: '${LocaleKeys.change.tr()} $text  THB.',
      title: LocaleKeys.payment_Success.tr(),
      lottieBuilder: Lottie.asset(
        'assets/payment_success.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: 0.3,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            popUntil!
                ? Navigator.of(context)
                    .popUntil(ModalRoute.withName(popToPage!))
                : Navigator.pop(context);
          },
          text: LocaleKeys.ok.tr(),
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  Future<void> dialogPaymentProcess(BuildContext context,
      {String? text, Function()? onPressed}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: TextStyle(
          fontSize: deviceType == 'tablet'
              ? Constants().screenWidth(context) * 0.015
              : Constants().screenWidth(context) * Constants.normalSize,
          fontWeight: FontWeight.bold),
      msgStyle: const TextStyle(fontSize: 18),
      msg: '${LocaleKeys.change.tr()} $text  THB.',
      title: LocaleKeys.payment_Success.tr(),
      lottieBuilder: Lottie.asset(
        'assets/payment_success.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: 0.3,
      context: context,
      actions: [
        IconsButton(
          onPressed: onPressed!,
          text: LocaleKeys.ok.tr(),
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  Future confirmDialog2(BuildContext context,
      {String? title, String? detail, VoidCallback? onPressed}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    Dialogs.materialDialog(
        barrierDismissible: false,
        title: title,
        msg: detail,
        color: Colors.white,
        context: context,
        dialogWidth: 0.38,
        titleStyle: TextStyle(
            fontSize: deviceType == 'tablet'
                ? Constants().screenWidth(context) * 0.015
                : Constants().screenWidth(context) * Constants.normalSize,
            fontWeight: FontWeight.bold),
        msgStyle: TextStyle(
          fontSize: deviceType == 'tablet'
              ? Constants().screenWidth(context) * 0.015
              : Constants().screenWidth(context) * Constants.normalSize,
        ),
        actions: [
          IconsButton(
            onPressed: onPressed!,
            text: LocaleKeys.ok.tr(),
            iconData: Icons.done,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsOutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: LocaleKeys.cancel.tr(),
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          )
        ]);
  }

  Future<void> dialogLoadding(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const LoadingData();
      },
    );
  }

  Future<void> dialogError(BuildContext context,
      {String? error, bool? isPopUntil, String? popToPage}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/error_lottie.json',
                fit: BoxFit.contain,
                height: Constants().screenheight(context) * 0.15,
                // width: Constants().screenheight(context) * 0.015,
              ),
              Text(
                LocaleKeys.something_went_wrong.tr(),
                style: TextStyle(
                    fontSize: deviceType == 'tablet'
                        ? Constants().screenWidth(context) * 0.015
                        : Constants().screenWidth(context) * Constants.boldSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              error!,
              style: TextStyle(
                  fontSize: deviceType == 'tablet'
                      ? Constants().screenWidth(context) * 0.015
                      : Constants().screenWidth(context) * Constants.boldSize,
                  overflow: TextOverflow.fade),
            ),
          ),
          actions: [
            IconsButton(
              onPressed: () {
                isPopUntil!
                    ? Navigator.of(context)
                        .popUntil(ModalRoute.withName(popToPage!))
                    : Navigator.pop(context);
              },
              text: LocaleKeys.ok.tr(),
              iconData: Icons.done,
              color: Colors.blue,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ],
        );
        ;
      },
    );
  }

  Future<void> dialogSuccess(BuildContext context,
      {bool? isPopUntil, String? popToPage}) {
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: TextStyle(
        fontSize: Constants().screenWidth(context) * Constants.normalSize,
      ),
      title: 'Success',
      lottieBuilder: Lottie.asset('assets/success_lottie.json'),
      dialogWidth: 0.25,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            isPopUntil!
                ? Navigator.of(context)
                    .popUntil(ModalRoute.withName(popToPage!))
                : Navigator.pop(context);
          },
          text: LocaleKeys.ok.tr(),
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
