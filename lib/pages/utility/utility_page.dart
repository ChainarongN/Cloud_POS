import 'dart:io';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class UtilityPage extends StatefulWidget {
  const UtilityPage({super.key});

  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  @override
  Widget build(BuildContext context) {
    var utilityRead = context.read<UtilityProvider>();
    var utilityWatch = context.watch<UtilityProvider>();
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('Utility'),
      ),
      backgroundColor: Constants.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                runSpacing: 10,
                spacing: 20,
                children: <Widget>[
                  ContainerStyle2(
                    title: 'Session Close',
                    icon: Icons.android,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.27,
                    shadowColor: Colors.deepOrange.shade300,
                    gradient1: Colors.deepOrange.shade100,
                    gradient2: Colors.deepOrange.shade200,
                    gradient3: Colors.deepOrange.shade400,
                    gradient4: Colors.deepOrange.shade400,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {
                      LoadingStyle().confirmDialog(context,
                          title: 'You need to close session. ? ',
                          onPressed: () {
                        utilityRead.setCloseAmountController('');
                        Navigator.maybePop(context).then((value) async {
                          bool val = await openAmountDialog(
                                  context, utilityWatch, utilityRead) ??
                              true;
                          if (val != false) {
                            if (utilityWatch.apiState == ApiState.COMPLETED) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                dialogResultCloseSession(
                                    context, utilityWatch, utilityRead, true);
                              });
                            }
                          }
                        });
                      });
                    },
                  ),
                  ContainerStyle2(
                    title: 'End Day',
                    icon: Icons.android,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.27,
                    shadowColor: Colors.red.shade600,
                    gradient1: Colors.red.shade400,
                    gradient2: Colors.red.shade500,
                    gradient3: Colors.red.shade700,
                    gradient4: Colors.red.shade700,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {
                      LoadingStyle().confirmDialog(context,
                          title:
                              'You need to end day. ? If it ends, you will not be able to open another session today.',
                          onPressed: () {
                        utilityRead.setCloseAmountController('');
                        Navigator.maybePop(context).then((value) async {
                          bool val = await openAmountDialog(
                                  context, utilityWatch, utilityRead) ??
                              true;
                          if (val != false) {
                            if (utilityWatch.apiState == ApiState.COMPLETED) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                dialogResultCloseSession(
                                    context, utilityWatch, utilityRead, false);
                              });
                            }
                          }
                        });
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  openAmountDialog(BuildContext context, UtilityProvider utilityWatch,
      UtilityProvider utilityRead) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
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
                      enabledBorder:
                          Constants().myinputborder(), //enabled border
                      focusedBorder:
                          Constants().myfocusborder(), //focused border
                    ),
                    style: const TextStyle(
                        color: Constants.textColor, fontSize: 20),
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
                  utilityRead.closeSession().then((value) {
                    if (utilityWatch.apiState == ApiState.ERROR) {
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        LoadingStyle()
                            .dialogError(context, utilityWatch.getErrorText);
                      });
                    } else {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName("/utilityPage"));
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

  Future<dynamic> dialogResultCloseSession(
      BuildContext context,
      UtilityProvider utilityWatch,
      UtilityProvider utilityRead,
      bool isSession) {
    return showDialog(
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: HtmlWidget(utilityWatch.getHtmlCloseSession)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: ContainerStyle2(
                      onPressed: () {
                        if (isSession) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/loginPage', (route) => false);
                        } else {
                          exit(0);
                        }
                      },
                      radius: 25,
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.height * 0.18,
                      title: 'พิมพ์ใบเสร็จ',
                      size: 20,
                      onlyText: false,
                      icon: Icons.add_chart_rounded,
                      shadowColor: Colors.green.shade400,
                      gradient1: Colors.green.shade200,
                      gradient2: Colors.green.shade300,
                      gradient3: Colors.green.shade500,
                      gradient4: Colors.green.shade500,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
