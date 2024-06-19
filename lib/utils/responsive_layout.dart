import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;

  const ResponsiveLayout(
      {super.key, required this.mobileBody, required this.tabletBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < Constants.MOBILE_WIDTH) {
        SharedPref().setResponsiveDevice('mobile');
        return mobileBody;
      } else {
        SharedPref().setResponsiveDevice('tablet');
        return tabletBody;
      }
    });
  }
}
