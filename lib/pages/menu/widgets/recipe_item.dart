import 'dart:ui';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  final String recipeName;
  final String recipeImage;
  const RecipeItem(
      {super.key, required this.recipeName, required this.recipeImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5, left: 3),
          height: Constants().screenheight(context) * 0.26,
          width: Constants().screenWidth(context) * 0.124,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(recipeImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: Constants().screenheight(context) * 0.01,
          left: Constants().screenWidth(context) * 0.007,
          right: Constants().screenWidth(context) * 0.005,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                height: Constants().screenheight(context) * 0.065,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppTextStyle()
                    .textNormal(recipeName, color: Colors.white, size: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}
