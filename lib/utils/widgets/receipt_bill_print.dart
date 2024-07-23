import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

showReceiptBillPrint(BuildContext context, String html,
    ScreenshotController controller, Function()? onPressed) {
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
                        String deviceType =
                            await SharedPref().getResponsiveDevice();
                        if (deviceType == 'tablet') {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/homePage'));
                        } else {
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
                        }
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
