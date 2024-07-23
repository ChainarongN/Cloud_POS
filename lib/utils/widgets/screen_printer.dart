import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:screenshot/screenshot.dart';

class ScreenPrinter extends StatelessWidget {
  final controller;
  final html;
  const ScreenPrinter({super.key, this.controller, this.html});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants().screenWidth(context),
      child: Screenshot(
        controller: controller,
        child: Container(
          color: Colors.white,
          child: Center(child: HtmlWidget(html)),
        ),
      ),
    );
  }
}
