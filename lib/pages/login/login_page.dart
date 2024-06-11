import 'package:cloud_pos/pages/login/mobile/login_mobile.dart';
import 'package:cloud_pos/pages/login/tablet/login_tablet.dart';
import 'package:cloud_pos/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      key: key,
      mobileBody: const LoginMobile(),
      tabletBody: const LoginTablet(),
    );
  }
}
