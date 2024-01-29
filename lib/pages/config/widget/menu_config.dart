import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

SingleChildScrollView menuConfig(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            configRead.setWidgetString('baseUrl');
          },
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.25,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 196, 255),
                  Color.fromARGB(255, 182, 212, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 182, 212, 255),
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AppTextStyle().textNormal('Base Url Setting',
                  size: 20, color: Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            configRead.setWidgetString('printer');
          },
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.25,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 138, 196, 255),
                  Color.fromARGB(255, 182, 212, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 182, 212, 255),
                    blurRadius: 8,
                    offset: Offset(0, 6)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AppTextStyle()
                  .textNormal('Printer Setting', size: 20, color: Colors.white),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.25,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 138, 196, 255),
                Color.fromARGB(255, 182, 212, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 182, 212, 255),
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppTextStyle().textNormal('Licenes Information',
                size: 20, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.25,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 138, 196, 255),
                Color.fromARGB(255, 182, 212, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 182, 212, 255),
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppTextStyle()
                .textNormal('About', size: 20, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
