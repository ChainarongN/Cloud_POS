import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/custom_error_widget.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:flutter/material.dart';

class LoadingStyle {
  LoadingStyle._internal();
  static final LoadingStyle _instance = LoadingStyle._internal();
  factory LoadingStyle() => _instance;

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
      context: context,
      builder: (BuildContext context) {
        return const LoaddingData();
      },
    );
  }

  Future<void> dialogError(BuildContext context, String errorString) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: CustomErrorWidget(errorMessage: errorString)),
            ),
          );
        });
  }
}
