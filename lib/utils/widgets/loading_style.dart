import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class LoadingStyle {
  LoadingStyle._internal();
  static final LoadingStyle _instance = LoadingStyle._internal();
  factory LoadingStyle() => _instance;

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
        return const LoaddingData();
      },
    );
  }

  Future<void> dialogError(BuildContext context,
      {String? error, bool? isPopUntil, String? popToPage}) async {
    String deviceType = await SharedPref().getResponsiveDevice();
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: TextStyle(
          fontSize: deviceType == 'tablet'
              ? Constants().screenWidth(context) * 0.015
              : Constants().screenWidth(context) * Constants.boldSize,
          fontWeight: FontWeight.bold),
      msgStyle: TextStyle(
          fontSize: deviceType == 'tablet'
              ? Constants().screenWidth(context) * 0.015
              : Constants().screenWidth(context) * Constants.boldSize,
          overflow: TextOverflow.fade),
      msg: error,
      title: LocaleKeys.something_went_wrong.tr(),
      lottieBuilder: Lottie.asset(
        'assets/error_lottie.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: 0.3,
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
