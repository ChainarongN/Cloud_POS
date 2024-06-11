import 'package:cloud_pos/pages/config/config_page.dart';
import 'package:cloud_pos/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/page.dart';

final Map<String, WidgetBuilder> routes = {
  '/homePage': (BuildContext context) => const HomePage(),
  '/menuPage': (BuildContext context) => const MenuPage(),
  '/loginPage': (BuildContext context) => const LoginPage(),
  '/configPage': (BuildContext context) => const ConfigPage(),
  '/utilityPage': (BuildContext context) => const UtilityPage(),
};
