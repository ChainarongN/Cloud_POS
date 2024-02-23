import 'package:cloud_pos/pages/login/widgets/btn_login.dart';
import 'package:cloud_pos/pages/login/widgets/footbar.dart';
import 'package:cloud_pos/pages/login/widgets/merchant_detail.dart';
import 'package:cloud_pos/pages/login/widgets/password_field.dart';
import 'package:cloud_pos/pages/login/widgets/username_field.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
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
                setLanguage(context, loginRead, loginWatch),
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
                        username(context),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.02),
                        password(context, loginWatch, loginRead),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.01),
                        AppTextStyle().textNormal(loginWatch.getErrorText,
                            color: Colors.red),
                        SizedBox(
                            height: Constants().screenheight(context) * 0.01),
                        btnLogin(context, loginRead, loginWatch),
                        merchantDetail(context),
                        const Spacer(),
                        footbar(context)
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

  Container setLanguage(
      BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
    return Container(
      margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                right: Constants().screenheight(context) * 0.06),
            width: Constants().screenWidth(context) * 0.09,
            height: Constants().screenheight(context) * 0.08,
            child: dropdownButton(
                loginRead: loginRead,
                loginWatch: loginWatch,
                itemMap: loginWatch.getLanguageList,
                value: context.locale.languageCode.toUpperCase(),
                onChanged: (value) {
                  loginRead.setLanguage(context, value!);
                }),
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField2<String> dropdownButton(
      {LoginProvider? loginWatch,
      LoginProvider? loginRead,
      List<String>? itemMap,
      String? value,
      Function(String?)? onChanged}) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      value: value,
      items: itemMap!.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: Constants().screenheight(context) * 0.018,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      iconStyleData: IconStyleData(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: Constants().screenheight(context) * 0.033,
      ),
    );
  }
}
