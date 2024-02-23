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
          width: Constants().screenWidth(context) * 0.1,
          height: Constants().screenheight(context) * 0.08,
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
              colors: homeWatch.getSexValue == homeWatch.getSexItem[index]
                  ? [
                      const Color.fromARGB(255, 113, 134, 255),
                      const Color.fromARGB(255, 157, 198, 255),
                    ]
                  : [
                      const Color.fromARGB(255, 165, 222, 249),
                      const Color.fromARGB(255, 177, 200, 241),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: AppTextStyle().textNormal(homeWatch.getSexItem[index]),
          ),
        ),
      ),
    ),
  );
}
