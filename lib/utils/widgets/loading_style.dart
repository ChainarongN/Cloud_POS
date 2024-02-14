import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/custom_error_widget.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:flutter/material.dart';

class LoadingStyle {
  LoadingStyle._internal();
  static final LoadingStyle _instance = LoadingStyle._internal();
  factory LoadingStyle() => _instance;

  Future<void> dialogPayment(BuildContext context, String text, bool popUntil,
      {String? popToPage}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTextStyle().textBold('Payment Success',
                      size: 22, color: Colors.greenAccent.shade700),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Change  ', style: TextStyle(fontSize: 20)),
                        TextSpan(
                          text: text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.blue.shade900),
                        ),
                        const TextSpan(
                            text: '  THB.', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => popUntil
                    ? Navigator.of(context)
                        .popUntil(ModalRoute.withName(popToPage!))
                    : Navigator.pop(context),
                child: AppTextStyle().textNormal('OK', size: 16),
              ),
            ],
          );
        });
  }

  Future<dynamic> confirmDialog(BuildContext context,
      {String? title, VoidCallback? onPressed}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: AppTextStyle()
                    .textBold(title!, color: Colors.red.shade400, size: 20),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: AppTextStyle().textNormal('OK', size: 16),
          ),
          TextButton(
            child: AppTextStyle()
                .textNormal('Cancel', size: 16, color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
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

  Future<void> dialogError(
      BuildContext context, String errorString, String popToPage) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: CustomErrorWidget(errorMessage: errorString)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context)
                    .popUntil(ModalRoute.withName(popToPage)),
                child: AppTextStyle().textNormal('OK', size: 16),
              ),
            ],
          );
        });
  }

  Future<void> dialogErrorNormalPop(BuildContext context, String errorString) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: CustomErrorWidget(errorMessage: errorString)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: AppTextStyle().textNormal('OK', size: 16),
              ),
            ],
          );
        });
  }
}
