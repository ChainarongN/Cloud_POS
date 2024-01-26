import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Wrap sex(HomeProvider homeWatch, HomeProvider homeRead, BuildContext context) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: List.generate(
      homeWatch.getSexItem.length,
      (index) => GestureDetector(
        onTap: () => homeRead.setSex(homeWatch.getSexItem[index]),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: homeWatch.getSexValue == homeWatch.getSexItem[index]
                  ? Border.all(color: Colors.blue.shade900)
                  : Border.all(color: Constants.primaryColor),
              boxShadow: const [
                BoxShadow(
                    color: Constants.primaryColor,
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: homeWatch.getSexValue == homeWatch.getSexItem[index]
                      ? [
                          Constants.primaryColor,
                          Constants.primaryColor,
                          Constants.primaryColor,
                          Constants.primaryColor,
                        ]
                      : [
                          Constants.secondaryColor,
                          Constants.secondaryColor,
                          Constants.secondaryColor,
                          Constants.secondaryColor,
                        ],
                  stops: const [0.1, 0.3, 0.9, 1.0])),
          child: Center(
            child: AppTextStyle().textNormal(homeWatch.getSexItem[index]),
          ),
        ),
      ),
    ),
  );
}
