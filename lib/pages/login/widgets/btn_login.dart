import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:flutter/material.dart';

GestureDetector btnLogin(
    BuildContext context, LoginProvider loginRead, LoginProvider loginWatch) {
  return GestureDetector(
    onTap: () {
      _dialogBuilder(context);
      loginRead.authToken().then((value) {
        Navigator.maybePop(context);
        Future.delayed(const Duration(milliseconds: 500), () {
          if (loginWatch.apisState == ApiState.COMPLETED) {
            Navigator.pushReplacementNamed(context, '/homePage');
          }
        });
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

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const LoaddingData();
    },
  );
}
