import 'dart:io';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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
              width: Constants().screenWidth(context),
              child: Wrap(
                runSpacing: 10,
                spacing: 20,
                children: <Widget>[
                  ContainerStyle2(
                    title: 'Session Close',
                    icon: Icons.android,
                    width: Constants().screenWidth(context) * 0.15,
                    height: Constants().screenheight(context) * 0.27,
                    shadowColor: Colors.deepOrange.shade300,
                    gradient1: Colors.deepOrange.shade100,
                    gradient2: Colors.deepOrange.shade200,
                    gradient3: Colors.deepOrange.shade400,
                    gradient4: Colors.deepOrange.shade400,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {
                      LoadingStyle().confirmDialog2(context,
                          title: 'Close Session',
                          detail: 'You need to close session. ? ',
                          onPressed: () {
                        utilityRead.setCloseAmountController('');
                        openAmountDialog(
                            context, utilityWatch, utilityRead, true);

                        // utilityRead.setCloseAmountController('');
                        // openAmountDialog(
                        //         context, utilityWatch, utilityRead, true)
                        //     .then((value) {
                        //   if (utilityWatch.apiState == ApiState.COMPLETED) {
                        //     dialogResultHtml(
                        //         context, utilityWatch, utilityRead, true);
                        //   }
                        // });

                        // utilityRead.setCloseAmountController('');
                        // Navigator.maybePop(context).then((value) async {
                        //   bool val = await openAmountDialog(
                        //           context, utilityWatch, utilityRead) ??
                        //       true;
                        //   if (val != false) {
                        //     if (utilityWatch.apiState == ApiState.COMPLETED) {
                        //       Future.delayed(const Duration(milliseconds: 500),
                        //           () {
                        //         dialogResultHtml(
                        //             context, utilityWatch, utilityRead, true);
                        //       });
                        //     }
                        //   }
                        // });
                      });
                    },
                  ),
                  ContainerStyle2(
                    title: 'End Day',
                    icon: Icons.android,
                    width: Constants().screenWidth(context) * 0.15,
                    height: Constants().screenheight(context) * 0.27,
                    shadowColor: Colors.red.shade600,
                    gradient1: Colors.red.shade400,
                    gradient2: Colors.red.shade500,
                    gradient3: Colors.red.shade700,
                    gradient4: Colors.red.shade700,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {
                      LoadingStyle().confirmDialog2(context,
                          title: 'End day',
                          detail:
                              'You need to end day. ? If it ends, you will not be able to open another session today.',
                          onPressed: () {
                        utilityRead.setCloseAmountController('');
                        openAmountDialog(
                            context, utilityWatch, utilityRead, false);

                        // utilityRead.setCloseAmountController('');
                        // openAmountDialog(
                        //         context, utilityWatch, utilityRead, false)
                        //     .then((value) async {
                        //   if (utilityWatch.apiState == ApiState.COMPLETED) {
                        //     await dialogResultHtml(
                        //             context, utilityWatch, utilityRead, false)
                        //         .then((value) {
                        //       if (utilityWatch.apiState != ApiState.LOADING) {
                        //         LoadingStyle().dialogLoadding(context);
                        //         utilityRead.endDay(context).then((value) async {
                        //           if (utilityWatch.apiState ==
                        //               ApiState.COMPLETED) {
                        //             Navigator.pop(context);
                        //             await dialogResultHtml(context,
                        //                 utilityWatch, utilityRead, false);
                        //             exit(0);
                        //           }
                        //         });
                        //       }
                        //     });
                        //   }
                        // });

                        // utilityRead.setCloseAmountController('');
                        // Navigator.maybePop(context).then((value) async {
                        //   bool val = await openAmountDialog(
                        //           context, utilityWatch, utilityRead) ??
                        //       true;
                        //   if (val != false) {
                        //     if (utilityWatch.apiState == ApiState.COMPLETED) {
                        //       Future.delayed(const Duration(milliseconds: 500),
                        //           () async {
                        //         dialogResultHtml(context, utilityWatch,
                        //                 utilityRead, false)
                        //             .then((value) async {
                        //           if (utilityWatch.apiState !=
                        //               ApiState.LOADING) {
                        //             LoadingStyle().dialogLoadding(context);
                        //             utilityRead
                        //                 .endDay(context)
                        //                 .then((value) async {
                        //               if (utilityWatch.apiState ==
                        //                   ApiState.COMPLETED) {
                        //                 Navigator.pop(context);
                        //                 await dialogResultHtml(context,
                        //                     utilityWatch, utilityRead, false);
                        //                 exit(0);
                        //               }
                        //             });
                        //           }
                        //         });
                        //       });
                        //     }
                        //   }
                        // });
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

  Future openAmountDialog(BuildContext context, UtilityProvider utilityWatch,
      UtilityProvider utilityRead, bool isSession) {
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
                  width: Constants().screenWidth(context) * 0.2,
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
                if (utilityWatch.getCloseAmountController.text.isNotEmpty &&
                    utilityWatch.apiState != ApiState.LOADING) {
                  LoadingStyle().dialogLoadding(context);
                  utilityRead.closeSession(context).then((value) {
                    if (utilityWatch.apiState == ApiState.COMPLETED) {
                      if (isSession) {
                        dialogResultHtml(
                            context, utilityWatch, utilityRead, isSession);
                      } else {
                        dialogResultHtml(
                                context, utilityWatch, utilityRead, isSession)
                            .then((value) {
                          LoadingStyle().dialogLoadding(context);
                          utilityRead.endDay(context).then((value) async {
                            if (utilityWatch.apiState == ApiState.COMPLETED) {
                              await dialogResultHtml(context, utilityWatch,
                                  utilityRead, isSession);
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

  Future<dynamic> dialogResultHtml(
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
                    width: Constants().screenWidth(context) * 0.55,
                    height: Constants().screenheight(context),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: HtmlWidget(utilityWatch.getHtml)),
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
                          Navigator.popUntil(
                              context, ModalRoute.withName('/utilityPage'));
                        }
                      },
                      radius: 25,
                      width: Constants().screenWidth(context) * 0.17,
                      height: Constants().screenheight(context) * 0.18,
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
