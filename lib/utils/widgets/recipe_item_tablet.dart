import 'dart:ui';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class RecipeItemTablet extends StatelessWidget {
  final String recipeName;
  final String recipeImage;
  const RecipeItemTablet(
      {super.key, required this.recipeName, required this.recipeImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: Constants().screenheight(context) * 0.007,
              left: Constants().screenheight(context) * 0.005),
          height: Constants().screenheight(context) * 0.28,
          width: Constants().screenWidth(context) * 0.124,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(recipeImage),
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
                padding:
                    EdgeInsets.all(Constants().screenheight(context) * 0.003),
                height: Constants().screenheight(context) * 0.07,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppTextStyle().textNormal(recipeName,
                    color: Colors.white,
                    size: Constants().screenheight(context) * 0.02),
              ),
            ),
          ),
        )
      ],
    );
  }
}
