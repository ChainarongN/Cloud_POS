import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
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
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    AppTextStyle().textNormal('vTec - Cloud POS', size: 18),
                    username(context),
                    const SizedBox(height: 20),
                    password(context, loginWatch, loginRead),
                    const SizedBox(height: 20),
                    btnLogin(context, loginRead, loginWatch),
                    merchantDetail(context),
                    const Spacer(),
                    footbar()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row footbar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        AppTextStyle().textNormal('Device ID : 6102-3452-2456-1234', size: 16),
        const Spacer(),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/configPage');
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Constants.secondaryColor,
                      Constants.primaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Constants.primaryColor,
                        blurRadius: 8,
                        offset: Offset(0, 6)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: AppTextStyle().textNormal('Configuration', size: 16),
                ),
              ),
            ),
            AppTextStyle().textNormal('Version : 0.0.19', size: 16),
          ],
        ),
      ],
    );
  }

  GestureDetector btnLogin(
      BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
    return GestureDetector(
      onTap: () {
        loginRead.authToken().then((value) {
          if (loginWatch.apisState == ApiState.COMPLETED) {
            Navigator.pushReplacementNamed(context, '/homePage');
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 165, 222, 249),
              Color.fromARGB(255, 177, 200, 241),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 189, 209, 247),
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AppTextStyle().textNormal('Login', size: 20),
        ),
      ),
    );
  }

  Container merchantDetail(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.11,
                child: AppTextStyle().textBold('Merchant Name : ', size: 16),
              ),
              AppTextStyle().textNormal('vTec Restaurant', size: 16)
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.11,
                child: AppTextStyle().textBold('Brand Name : ', size: 16),
              ),
              AppTextStyle().textNormal('vTec Brand', size: 16)
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.11,
                child: AppTextStyle().textBold('Outlet Name : ', size: 16),
              ),
              AppTextStyle().textNormal('vTec Demo Store', size: 16)
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.11,
                child: AppTextStyle().textBold('POS Name : ', size: 16),
              ),
              AppTextStyle().textNormal('POS Demo', size: 16)
            ],
          ),
        ],
      ),
    );
  }

  SizedBox password(
      BuildContext context, LoginProvider loginWatch, LoginProvider loginRead) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          labelText: "Password",
          border: myinputborder(),
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 25, right: 15),
            child: Icon(Icons.lock),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: loginWatch.passwordVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () => loginRead.setPasswordVisible(),
            ),
          ),
        ),
        obscureText: loginWatch.passwordVisible,
        style: const TextStyle(color: Constants.textColor, fontSize: 20),
      ),
    );
  }

  Container username(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          labelText: "Username",
          border: myinputborder(), //normal border
          enabledBorder: myinputborder(), //enabled border
          focusedBorder: myfocusborder(), //focused border
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 25, right: 15),
            child: Icon(Icons.people),
          ),
        ),
        style: const TextStyle(color: Constants.textColor, fontSize: 20),
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
