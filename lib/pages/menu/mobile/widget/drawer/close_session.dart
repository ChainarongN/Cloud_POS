import 'dart:io';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/providers/utility/utility_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:screenshot/screenshot.dart';

Future openAmountSessionDialog(BuildContext context,
    UtilityProvider utilityWatch, UtilityProvider utilityRead, bool isSession) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.15,
          child: Column(
            children: <Widget>[
              Container(
                width: Constants().screenWidth(context),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: utilityWatch.getCloseAmountController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Open amount',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style:
                      const TextStyle(color: Constants.textColor, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal('OK', size: 18),
            onPressed: () async {
              if (utilityWatch.getCloseAmountController.text.isNotEmpty) {
                LoadingStyle().dialogLoadding(context);
                utilityRead.closeSession(context).then((value) {
                  if (utilityWatch.apiState == ApiState.COMPLETED) {
                    if (isSession) {
                      showHtmlDialog(
                          context, utilityWatch, utilityRead, isSession);
                    } else {
                      showHtmlDialog(
                              context, utilityWatch, utilityRead, isSession)
                          .then((value) {
                        utilityRead.endDay(context).then((value) async {
                          if (utilityWatch.apiState == ApiState.COMPLETED) {
                            await showHtmlDialog(
                                context, utilityWatch, utilityRead, isSession);
                            Future.delayed(const Duration(milliseconds: 500),
                                () => exit(0));
                          }
                        });
                      });
                    }
                  }
                });
              }
            },
          ),
          TextButton(
            child: AppTextStyle()
                .textNormal('Cancel', size: 18, color: Colors.red),
            onPressed: () async {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}

showHtmlDialog(BuildContext context, UtilityProvider utilityWatch,
    UtilityProvider utilityRead, bool isSession) {
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
                      // thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: Constants().screenWidth(context),
                          child: HtmlWidget(utilityWatch.getHtml),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/loginPage', (route) => false);
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
