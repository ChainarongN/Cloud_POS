// import 'package:cloud_pos/networks/api_service.dart';
// import 'package:cloud_pos/providers/menu/menu_provider.dart';
// import 'package:cloud_pos/service/printer.dart';
// import 'package:cloud_pos/translations/locale_key.g.dart';
// import 'package:cloud_pos/utils/constants.dart';
// import 'package:cloud_pos/utils/widgets/container_style_2.dart';
// import 'package:cloud_pos/utils/widgets/loading_style.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:cloud_pos/providers/provider.dart';
// import 'package:flutter/services.dart';
// 
// Row summaryBtnTablet(
//     BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       GestureDetector(
//         onTap: () async {
//           if (menuWatch.transactionModel!.responseObj!.orderList!.isEmpty) {
//             DialogStyle().dialogError(context,
//                 error: LocaleKeys.must_have_at_least_1_order.tr(),
//                 isPopUntil: true,
//                 popToPage: '/menuPage');
//           } else {
//             DialogStyle().dialogLoadding(context);
//             await menuRead.orderSummary(context).then((value) {
//               if (menuWatch.apiState == ApiState.COMPLETED) {
//                 dialogResultHtml(
//                     context, menuWatch.getHtmlOrderSummary, menuWatch);
//               }
//             });
//           }
//         },
//         child: Container(
//           width: Constants().screenWidth(context) * 0.15,
//           height: Constants().screenheight(context) * 0.08,
//           margin: EdgeInsets.all(Constants().screenheight(context) * 0.0018),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Constants.primaryColor),
//             color: Colors.blue.shade800,
//             boxShadow: const [
//               BoxShadow(
//                   color: Constants.primaryColor,
//                   blurRadius: 8,
//                   offset: Offset(0, 6)),
//             ],
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Icon(Icons.receipt_long,
//                     color: Colors.white,
//                     size: Constants().screenheight(context) * 0.055),
//               ],
//             ),
//           ),
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           menuRead.setTabToPayment(5);
//         },
//         child: Container(
//           width: Constants().screenWidth(context) * 0.15,
//           height: Constants().screenheight(context) * 0.085,
//           margin: EdgeInsets.all(Constants().screenheight(context) * 0.0018),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Constants.primaryColor),
//             color: Colors.blue.shade800,
//             boxShadow: const [
//               BoxShadow(
//                   color: Constants.primaryColor,
//                   blurRadius: 8,
//                   offset: Offset(0, 6)),
//             ],
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Icon(Icons.local_printshop_rounded,
//                     color: Colors.white,
//                     size: Constants().screenheight(context) * 0.055),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
// 
// Future<dynamic> dialogResultHtml(
//     BuildContext context, String html, MenuProvider menuWatch) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(
//                     right: Constants().screenWidth(context) * 0.05,
//                   ),
//                   child: Scrollbar(
//                     child: SingleChildScrollView(
//                       child: SizedBox(
//                         width: Constants().screenWidth(context) * 0.29,
//                         child: Screenshot(
//                           controller: menuWatch.screenshotOrderSumController,
//                           child: HtmlWidget(html),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(top: 5),
//                         child: ContainerStyle2(
//                           onPressed: () {
//                             if (menuWatch.apiState != ApiState.LOADING) {
//                               menuWatch.apiState = ApiState.LOADING;
//                               DialogStyle().dialogLoadding(context);
//                               menuWatch.screenshotOrderSumController
//                                   .capture(
//                                       delay: const Duration(seconds: 1),
//                                       pixelRatio: 1.3)
//                                   .then((Uint8List? value) async {
//                                 await Printer()
//                                     .printReceipt(value!)
//                                     .then((value) {
//                                   menuWatch.apiState = ApiState.COMPLETED;
//                                   Navigator.of(context).popUntil(
//                                       ModalRoute.withName('/menuPage'));
//                                 });
//                               });
//                             }
//                           },
//                           radius: 25,
//                           width: Constants().screenWidth(context) * 0.17,
//                           height: Constants().screenheight(context) * 0.18,
//                           title: LocaleKeys.print_bill.tr(),
//                           size: 20,
//                           onlyText: false,
//                           icon: Icons.add_chart_rounded,
//                           shadowColor: Colors.green.shade400,
//                           gradient1: Colors.green.shade200,
//                           gradient2: Colors.green.shade300,
//                           gradient3: Colors.green.shade500,
//                           gradient4: Colors.green.shade500,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 10),
//                         child: ContainerStyle2(
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .popUntil(ModalRoute.withName('/menuPage'));
//                           },
//                           radius: 25,
//                           width: Constants().screenWidth(context) * 0.17,
//                           height: Constants().screenheight(context) * 0.18,
//                           title: LocaleKeys.close.tr(),
//                           size: 20,
//                           icon: Icons.close_rounded,
//                           onlyText: false,
//                           shadowColor: Colors.red.shade400,
//                           gradient1: Colors.red.shade200,
//                           gradient2: Colors.red.shade300,
//                           gradient3: Colors.red.shade500,
//                           gradient4: Colors.red.shade500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
