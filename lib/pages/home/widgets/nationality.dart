import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Wrap nationality(
    HomeProvider homeWatch, HomeProvider homeRead, BuildContext context) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: List.generate(
      homeWatch.getNationalityItem.length,
      (index) => GestureDetector(
        onTap: () =>
            homeRead.setNationality(homeWatch.getNationalityItem[index]),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.09,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: homeWatch.getNationalityItem[index] ==
                    homeWatch.getNationalityValue
                ? Border.all(color: Colors.blue.shade900)
                : Border.all(color: Constants.primaryColor),
            gradient: LinearGradient(
              colors: homeWatch.getNationalityItem[index] ==
                      homeWatch.getNationalityValue
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
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 189, 209, 247),
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: AppTextStyle().textNormal(
                homeWatch.getNationalityItem[index],
                color: Constants.textColor),
          ),
        ),
      ),
    ),
  );
}
