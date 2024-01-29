import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class ContainerStyle extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color primaryColor;
  final Color secondaryColor;
  const ContainerStyle(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.primaryColor,
      required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      // margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            primaryColor,
            secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: secondaryColor, blurRadius: 8, offset: const Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 25),
                child: const Icon(
                  Icons.cloud_done_outlined,
                  size: 40,
                  color: Colors.white,
                )),
            AppTextStyle().textNormal(title, size: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
