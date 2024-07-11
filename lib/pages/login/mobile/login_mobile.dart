import 'package:cloud_pos/pages/login/mobile/widgets/btn_login_mobile.dart';
import 'package:cloud_pos/pages/login/mobile/widgets/footbar_mobile.dart';
import 'package:cloud_pos/pages/login/mobile/widgets/merchant_detail_mobile.dart';
import 'package:cloud_pos/pages/login/mobile/widgets/password_field_mobile.dart';
import 'package:cloud_pos/pages/login/mobile/widgets/set_language_mobile.dart';
import 'package:cloud_pos/pages/login/mobile/widgets/username_field_mobile.dart';
import 'package:cloud_pos/providers/login/login_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
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
                setLanguageMobile(context, loginRead, loginWatch),
                Container(
                  margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.05),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(114, 179, 248, 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: Constants().screenWidth(context) * 0.85,
                  height: Constants().screenheight(context) * 0.65,
                  child: Padding(
                    padding: EdgeInsets.all(
                        Constants().screenheight(context) * 0.025),
                    child: Column(
                      children: [
                        AppTextStyle().textNormal('vTec - Cloud POS',
                            size: Constants().screenheight(context) * 0.02),
                        usernameMobile(context, loginWatch),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.014),
                        passwordMobile(context, loginWatch, loginRead),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.005),
                        AppTextStyle().textNormal(loginWatch.getErrorText,
                            color: Colors.red),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.005),
                        btnLoginMobile(context, loginRead, loginWatch),
                        merchantDetailMobile(context),
                        const Spacer(),
                        footbarMobile(context, loginWatch)
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
