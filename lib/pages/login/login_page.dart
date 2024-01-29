import 'package:cloud_pos/pages/login/widgets/btn_login.dart';
import 'package:cloud_pos/pages/login/widgets/footbar.dart';
import 'package:cloud_pos/pages/login/widgets/merchant_detail.dart';
import 'package:cloud_pos/pages/login/widgets/password_field.dart';
import 'package:cloud_pos/pages/login/widgets/username_field.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var loginRead = context.read<LoginProvider>();
    var loginWatch = context.watch<LoginProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.bgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(114, 179, 248, 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    AppTextStyle().textNormal('vTec - Cloud POS', size: 18),
                    username(context),
                    const SizedBox(height: 20),
                    password(context, loginWatch, loginRead),
                    const SizedBox(height: 10),
                    AppTextStyle()
                        .textNormal(loginWatch.getErrorText, color: Colors.red),
                    const SizedBox(height: 15),
                    btnLogin(context, loginRead, loginWatch),
                    merchantDetail(context),
                    const Spacer(),
                    footbar(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
