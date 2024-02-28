import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 100,
          ),
          Column(
            children: [
              AppTextStyle().textNormal(LocaleKeys.something_went_wrong.tr(),
                  size: 20, color: Colors.red),
              AppTextStyle().textNormal(errorMessage)
            ],
          ),
        ],
      ),
    );
  }
}
