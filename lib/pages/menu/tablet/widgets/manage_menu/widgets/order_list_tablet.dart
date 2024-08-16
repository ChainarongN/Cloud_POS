import 'package:cloud_pos/providers/menu/functions/manage_order_func.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

SizedBox orderListTablet(
    MenuProvider menuWatch, MenuProvider menuRead, BuildContext context) {
  return menuWatch.transactionModel == null ||
          menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
      ? SizedBox(
          height: Constants().screenheight(context) * 0.56,
          child: Center(
              child: AppTextStyle().textNormal(LocaleKeys.there_is_no_menu.tr(),
                  size: Constants().screenheight(context) * 0.020)),
        )
      : SizedBox(
          width: Constants().screenWidth(context),
          height: Constants().screenheight(context) * 0.56,
          child: ListView.builder(
            itemCount:
                menuWatch.transactionModel!.responseObj!.orderList!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    bottom: Constants().screenheight(context) * 0.015),
                width: Constants().screenWidth(context),
                decoration: BoxDecoration(
                  color: Constants.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Constants.primaryColor,
                        blurRadius: 4,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: slidable(menuWatch, index, menuRead, context),
              );
            },
          ),
        );
}

Slidable slidable(MenuProvider menuWatch, int index, MenuProvider menuRead,
    BuildContext context) {
  return Slidable(
    endActionPane: ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          flex: 2,
          borderRadius: BorderRadius.circular(10),
          onPressed: (contextSlidable) {
            menuRead.manageCountOrder(context, index, 'delete');
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.save,
          label: LocaleKeys.delete.tr(),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              AppTextStyle().textBold(
                menuWatch
                    .transactionModel!.responseObj!.orderList![index].itemName!,
                size: Constants().screenheight(context) * 0.024,
              ),
              const Spacer(),
              AppTextStyle().textBold(
                menuWatch.transactionModel!.responseObj!.orderList![index]
                    .retailPrice!
                    .toString(),
                size: Constants().screenheight(context) * 0.024,
              ),
            ],
          ),
          Column(
            children: List.generate(
              menuWatch.transactionModel!.responseObj!.orderList![index]
                  .childItemList!.length,
              (indexchildItemList) => Row(
                children: [
                  AppTextStyle().textNormal(
                    menuWatch.transactionModel!.responseObj!.orderList![index]
                        .childItemList![indexchildItemList].itemName!,
                    size: Constants().screenheight(context) * 0.022,
                  ),
                  const Spacer(),
                  AppTextStyle().textNormal(
                    menuWatch.transactionModel!.responseObj!.orderList![index]
                        .childItemList![indexchildItemList].unitPrice!
                        .toString(),
                    size: Constants().screenheight(context) * 0.022,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ManageOrderFunc().editOrder(context, index);
                  },
                  child: AppTextStyle().textBold('แก้ไข',
                      size: Constants().screenheight(context) * 0.022,
                      color: Constants.primaryColor),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () =>
                      menuRead.manageCountOrder(context, index, 'remove'),
                  child: Icon(Icons.remove_circle_outline,
                      color: Colors.red,
                      size: Constants().screenheight(context) * 0.045),
                ),
                GestureDetector(
                  onTap: () {
                    menuRead.clearReasonText();
                    openQtyDialog(context, menuWatch, menuRead, index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Constants().screenWidth(context) * 0.02,
                    child: AppTextStyle().textBold(
                      menuWatch
                          .transactionModel!.responseObj!.orderList![index].qty!
                          .toInt()
                          .toString(),
                      size: Constants().screenheight(context) * 0.022,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => menuRead.manageCountOrder(context, index, 'add'),
                  child: Icon(Icons.add_box_outlined,
                      color: Constants.primaryColor,
                      size: Constants().screenheight(context) * 0.045),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Padding orderContainer(BuildContext context, MenuProvider menuWatch, int index,
//     MenuProvider menuRead) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: <Widget>[
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AppTextStyle().textBold(
//               menuWatch
//                   .transactionModel!.responseObj!.orderList![index].itemName!,
//               size: Constants().screenheight(context) * 0.025,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: List.generate(
//                 menuWatch.transactionModel!.responseObj!.orderList![index]
//                     .childItemList!.length,
//                 (indexChildItemList) => AppTextStyle().textNormal(
//                   menuWatch.transactionModel!.responseObj!.orderList![index]
//                       .childItemList![indexChildItemList].itemName!,
//                   size: Constants().screenheight(context) * 0.022,
//                 ),
//               ),
//             )
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             AppTextStyle().textBold(
//               menuWatch
//                   .transactionModel!.responseObj!.orderList![index].retailPrice!
//                   .toString(),
//               size: Constants().screenheight(context) * 0.025,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: List.generate(
//                 menuWatch.transactionModel!.responseObj!.orderList![index]
//                     .childItemList!.length,
//                 (indexChildItemList) => AppTextStyle().textNormal(
//                   menuWatch.transactionModel!.responseObj!.orderList![index]
//                       .childItemList![indexChildItemList].unitPrice!
//                       .toString(),
//                   size: Constants().screenheight(context) * 0.022,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () =>
//                       menuRead.manageCountOrder(context, index, 'remove'),
//                   child: Icon(Icons.remove_circle_outline,
//                       color: Colors.red,
//                       size: Constants().screenheight(context) * 0.045),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     menuRead.clearReasonText();
//                     openQtyDialog(context, menuWatch, menuRead, index);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     width: Constants().screenWidth(context) * 0.02,
//                     child: AppTextStyle().textBold(
//                       menuWatch
//                           .transactionModel!.responseObj!.orderList![index].qty!
//                           .toInt()
//                           .toString(),
//                       size: Constants().screenheight(context) * 0.022,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => menuRead.manageCountOrder(context, index, 'add'),
//                   child: Icon(Icons.add_box_outlined,
//                       color: Constants.primaryColor,
//                       size: Constants().screenheight(context) * 0.045),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }

openQtyDialog(BuildContext context, MenuProvider menuWatch,
    MenuProvider menuRead, int index) {
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
                  controller: menuWatch.valueQtyOrderController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: '${LocaleKeys.enter_your_qty.tr()}.',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.027),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenheight(context) * 0.025),
            onPressed: () {
              menuRead.manageCountOrder(context, index, 'dialog');
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenheight(context) * 0.025,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}
