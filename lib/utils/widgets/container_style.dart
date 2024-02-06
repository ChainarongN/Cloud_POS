import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class ContainerStyle extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color primaryColor;
  final Color secondaryColor;
  final bool selected;
  const ContainerStyle(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.primaryColor,
      required this.secondaryColor,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: selected
              ? [
                  const Color.fromARGB(255, 113, 134, 255),
                  const Color.fromARGB(255, 157, 198, 255),
                ]
              : [
                  secondaryColor,
                  primaryColor,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: selected
                  ? const Color.fromARGB(255, 157, 198, 255)
                  : primaryColor,
              blurRadius: 8,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: AppTextStyle().textNormal(title, size: 16, color: Colors.white),
      ),
    );
  }
}
