import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

showReceiptBillPrint(BuildContext context, String html,
    ScreenshotController controller, Function()? onPressed) async {
  String deviceType = await SharedPref().getResponsiveDevice();
  if (deviceType == 'tablet') {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: Constants().screenWidth(context) * 0.05,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: Constants().screenWidth(context) * 0.29,
                        child: Screenshot(
                          controller: controller,
                          child: HtmlWidget(html),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: ContainerStyle2(
                          onPressed: onPressed!,
                          radius: 25,
                          width: Constants().screenWidth(context) * 0.17,
                          height: Constants().screenheight(context) * 0.18,
                          title: LocaleKeys.print_bill.tr(),
                          size: 20,
                          onlyText: false,
                          icon: Icons.add_chart_rounded,
                          shadowColor: Colors.green.shade400,
                          gradient1: Colors.green.shade200,
                          gradient2: Colors.green.shade300,
                          gradient3: Colors.green.shade500,
                          gradient4: Colors.green.shade500,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ContainerStyle2(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/homePage'));
                          },
                          radius: 25,
                          width: Constants().screenWidth(context) * 0.17,
                          height: Constants().screenheight(context) * 0.18,
                          title: LocaleKeys.close.tr(),
                          size: 20,
                          icon: Icons.close_rounded,
                          onlyText: false,
                          shadowColor: Colors.red.shade400,
                          gradient1: Colors.red.shade200,
                          gradient2: Colors.red.shade300,
                          gradient3: Colors.red.shade500,
                          gradient4: Colors.red.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return ClipPath(
          clipper: ZigZagClipper(),
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Constants().screenWidth(context) * 0.05,
                  right: Constants().screenWidth(context) * 0.05,
                  top: Constants().screenheight(context) * 0.05,
                  bottom: Constants().screenheight(context) * 0.05),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: Constants().screenheight(context) * 0.025),
                    height: Constants().screenheight(context) * 0.7,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: Constants().screenWidth(context),
                          child: Screenshot(
                            controller: controller,
                            child: Container(
                              color: Colors.white,
                              child: Center(child: HtmlWidget(html)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onPressed,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: Constants().screenWidth(context) * 0.035),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.print,
                            size: Constants().screenWidth(context) * 0.1,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var homePvd = context.read<HomeProvider>();
                          var menuPvd = context.read<MenuProvider>();
                          await homePvd.openTransaction(context).then((value) {
                            if (homePvd.apisState == ApiState.COMPLETED) {
                              menuPvd
                                  .setTranData(
                                      tranModel:
                                          json.encode(homePvd.openTranModel))
                                  .then((value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/menuPage', (route) => false);
                              });
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.cancel,
                            size: Constants().screenWidth(context) * 0.1,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ), // Comment this out if you want to replace ClipPath with ClipOval
        );
      },
    );
  }
}

showOrderSumDialog(
    BuildContext context, String html, ScreenshotController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return ClipPath(
        clipper: ZigZagClipper(),
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(Constants().screenWidth(context) * 0.1),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: Constants().screenheight(context) * 0.025),
                  height: Constants().screenheight(context) * 0.7,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: Constants().screenWidth(context),
                        child: Screenshot(
                          controller: controller,
                          child: Container(
                            color: Colors.white,
                            child: Center(child: HtmlWidget(html)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        controller
                            .capture(
                                delay: const Duration(seconds: 1),
                                pixelRatio: 1.2)
                            .then((Uint8List? value) async {
                          Printer().printReceipt(value!);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: Constants().screenWidth(context) * 0.03),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.print,
                          size: Constants().screenWidth(context) * 0.1,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.cancel,
                          size: Constants().screenWidth(context) * 0.1,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ), // Comment this out if you want to replace ClipPath with ClipOval
      );
    },
  );
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 0;
    double y = size.height;
    double increment = size.width / 20;

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height * .95 : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}
