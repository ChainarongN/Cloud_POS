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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                        AppTextStyle().textNormal(loginWatch.getErrorText,
                            color: Colors.red),
                        const SizedBox(height: 15),
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
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 30),
            width: MediaQuery.of(context).size.width * 0.09,
            height: MediaQuery.of(context).size.height * 0.08,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: value,
      items: itemMap!.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
    );
  }
}
