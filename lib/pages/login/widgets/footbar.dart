import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Row footbar(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      AppTextStyle().textNormal('Device ID : 6102-3452-2456-1234', size: 16),
      const Spacer(),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/configPage');
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Constants.secondaryColor,
                    Constants.primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Constants.primaryColor,
                      blurRadius: 8,
                      offset: Offset(0, 6)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AppTextStyle().textNormal('Configuration', size: 16),
              ),
            ),
          ),
          AppTextStyle().textNormal('Version : 0.0.19', size: 16),
        ],
      ),
    ],
  );
}
