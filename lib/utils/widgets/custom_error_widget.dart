import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 100,
          ),
          Column(
            children: [
              AppTextStyle().textNormal('Something went wrong',
                  size: 20, color: Colors.red),
              AppTextStyle().textNormal(errorMessage)
            ],
          ),
        ],
      ),
    );
  }
}
