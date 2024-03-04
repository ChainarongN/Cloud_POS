import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class ContainerStyle2 extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? shadowColor;
  final Color? gradient1;
  final Color? gradient2;
  final Color? gradient3;
  final Color? gradient4;
  final double? size;
  final double radius;
  final bool? onlyText;
  final VoidCallback onPressed;
  const ContainerStyle2(
      {super.key,
      this.title,
      this.icon,
      this.shadowColor,
      this.gradient1,
      this.gradient2,
      this.gradient3,
      this.gradient4,
      this.width,
      this.height,
      required this.onPressed,
      this.onlyText,
      this.size,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    onlyText ?? false;
    size ?? 20;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            boxShadow: [
              BoxShadow(
                color: shadowColor!,
                offset: const Offset(0, 20),
                blurRadius: 30,
                spreadRadius: -5,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  gradient1!,
                  gradient2!,
                  gradient3!,
                  gradient4!,
                ],
                stops: const [
                  0.1,
                  0.3,
                  0.9,
                  1.0
                ])),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: onlyText!
                ? [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: AppTextStyle()
                          .textNormal(title!, size: size, color: Colors.white),
                    )
                  ]
                : [
                    Icon(icon, size: 60, color: Colors.grey[100]),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: AppTextStyle()
                          .textNormal(title!, size: size, color: Colors.white),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
