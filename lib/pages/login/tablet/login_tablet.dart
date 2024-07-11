import 'package:cloud_pos/pages/login/tablet/widgets/btn_login_tablet.dart';
import 'package:cloud_pos/pages/login/tablet/widgets/footbar_tablet.dart';
import 'package:cloud_pos/pages/login/tablet/widgets/merchant_detail_tablet.dart';
import 'package:cloud_pos/pages/login/tablet/widgets/password_field_tablet.dart';
import 'package:cloud_pos/pages/login/tablet/widgets/set_language_tablet.dart';
import 'package:cloud_pos/pages/login/tablet/widgets/username_field_tablet.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginTablet extends StatefulWidget {
  const LoginTablet({super.key});

  @override
  State<LoginTablet> createState() => _LoginTabletState();
}

class _LoginTabletState extends State<LoginTablet> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var loginRead = context.read<LoginProvider>();
    var loginWatch = context.watch<LoginProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Constants().screenWidth(context),
          height: Constants().screenheight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.bgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                setLanguageTablet(context, loginRead, loginWatch),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(114, 179, 248, 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: Constants().screenWidth(context) * 0.4,
                  height: Constants().screenheight(context) * 0.8,
                  child: Padding(
                    padding: EdgeInsets.all(
                        Constants().screenheight(context) * 0.04),
                    child: Column(
                      children: [
                        AppTextStyle().textNormal('vTec - Cloud POS',
                            size: Constants().screenheight(context) * 0.024),
                        usernameTablet(context, loginWatch),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.02),
                        passwordTablet(context, loginWatch, loginRead),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.01),
                        AppTextStyle().textNormal(loginWatch.getErrorText,
                            color: Colors.red),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.01),
                        btnLoginTablet(context, loginRead, loginWatch),
                        merchantDetailTablet(context, loginRead, loginWatch),
                        const Spacer(),
                        footbarTablet(context, loginWatch)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
