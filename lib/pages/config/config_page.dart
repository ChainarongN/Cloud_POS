import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('vTec - Cloud POS Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menuConfig(context),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const VerticalDivider(thickness: 2),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  baseUrlConfig(context),
                  Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              AppTextStyle().textBold('Merchant Name')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Card(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Card(),
                      ),
                    ],
                  ),
                  saveConfigBtn(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container saveConfigBtn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.45,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 113, 134, 255),
            Color.fromARGB(255, 157, 198, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 157, 198, 255),
              blurRadius: 8,
              offset: Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 25),
                child: const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.white,
                )),
            AppTextStyle()
                .textNormal('Save Config', size: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Column baseUrlConfig(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100.withOpacity(0.1),
                labelText: "Platform API Base Url",
                border: myinputborder(),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Icon(
                    Icons.cloud_outlined,
                    size: 40,
                  ),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.cancel),
                )),
            style: const TextStyle(color: Constants.textColor, fontSize: 20),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.45,
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 113, 134, 255),
                Color.fromARGB(255, 157, 198, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 157, 198, 255),
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 25),
                    child: const Icon(
                      Icons.cloud_done_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
                AppTextStyle().textNormal('Get Shop Data Information',
                    size: 20, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView menuConfig(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
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
              child: AppTextStyle().textNormal('Base Url Setting',
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
                  .textNormal('Printer Setting', size: 20, color: Colors.white),
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

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.black45),
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
