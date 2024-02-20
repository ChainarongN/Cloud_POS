import 'package:cloud_pos/utils/widgets/loading_data.dart';
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
      {String? text, bool? popUntil, String? popToPage}) {
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      msgStyle: const TextStyle(fontSize: 18),
      msg: 'Change $text  THB.',
      title: 'Payment Success',
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
          text: 'OK',
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
    Dialogs.materialDialog(
        barrierDismissible: false,
        title: title,
        msg: detail,
        color: Colors.white,
        context: context,
        dialogWidth: 0.38,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        msgStyle: const TextStyle(fontSize: 18),
        actions: [
          IconsButton(
            onPressed: onPressed!,
            text: 'OK',
            iconData: Icons.done,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsOutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Cancel',
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
      {String? error, bool? isPopUntil, String? popToPage}) {
    return Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      // msgStyle: const TextStyle(fontSize: 16, overflow: TextOverflow.fade),
      msg: error,
      title: 'Something went wrong',
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
          text: 'OK',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
