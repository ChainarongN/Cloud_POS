import 'package:cloud_pos/pages/menu/mobile/menu_mobile.dart';
import 'package:cloud_pos/pages/menu/tablet/menu_tablet.dart';
import 'package:cloud_pos/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      key: key,
      mobileBody: const MenuMobile(),
      tabletBody: const MenuTablet(),
    );
  }
}
