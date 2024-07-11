import 'dart:typed_data';

import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

showOrderSumDialog(BuildContext context, String html, MenuProvider menuWatch) {
  showDialog(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        child: ClipPath(
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
                            controller: menuWatch.screenshotOrderSumController,
                            child: HtmlWidget(html),
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
                          menuWatch.screenshotOrderSumController
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
        ),
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
