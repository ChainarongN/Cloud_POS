import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaddingData extends StatelessWidget {
  const LoaddingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: Constants().screenheight(context) * 0.3,
        width: Constants().screenWidth(context) * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Constants.primaryColor,
                size: 110,
              ),
            ),
            AppTextStyle()
                .textNormal(LocaleKeys.loading_please_wait.tr(), size: 18),
          ],
        ),
      ),
    );
  }
}
