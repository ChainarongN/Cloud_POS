import 'package:cloud_pos/pages/config/mobile/config_mobile.dart';
import 'package:cloud_pos/pages/config/tablet/config_tablet.dart';
import 'package:cloud_pos/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      key: key,
      mobileBody: const ConfigMobile(),
      tabletBody: const ConfigTablet(),
    );
  }
}
