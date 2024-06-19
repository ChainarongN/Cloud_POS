import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

SizedBox orderListTablet(
    MenuProvider menuWatch, MenuProvider menuRead, BuildContext context) {
  return menuWatch.transactionModel == null ||
          menuWatch.transactionModel!.responseObj!.orderList!.isEmpty
      ? SizedBox(
          height: Constants().screenheight(context) * 0.3,
          child: Center(
              child:
                  AppTextStyle().textNormal(LocaleKeys.there_is_no_menu.tr())),
        )
      : SizedBox(
          height: Constants().screenheight(context) * 0.3,
          child: ListView(
            children: [
              Column(
                children: List.generate(
                  menuWatch.transactionModel!.responseObj!.orderList!.length,
                  (index) => Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: (contextSlidable) {
                            showDialog(
                                context: contextSlidable,
                                builder: (context) {
                                  return AlertDialog(
                                    title: AppTextStyle().textNormal(menuWatch
                                        .transactionModel!
                                        .responseObj!
                                        .orderList![index]
                                        .itemName!),
                                    content: TextField(
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          hintText: LocaleKeys.input_your_remark
                                              .tr()),
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textNormal(
                                            LocaleKeys.cancel.tr(),
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                          width: Constants()
                                                  .screenheight(context) *
                                              0.025),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.ok.tr(),
                                            color: Constants.primaryColor),
                                      ),
                                    ],
                                  );
                                });
                          },
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: LocaleKeys.remark.tr(),
                        ),
                        SlidableAction(
                          flex: 2,
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
                    child: Container(
                      height: Constants().screenheight(context) * 0.065,
                      margin: EdgeInsets.only(
                          bottom: Constants().screenheight(context) * 0.01,
                          right: Constants().screenheight(context) * 0.01),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => menuRead.manageCountOrder(
                                context, index, 'remove'),
                            child: Icon(Icons.remove_circle_outline,
                                color: Colors.red,
                                size:
                                    Constants().screenheight(context) * 0.045),
                          ),
                          GestureDetector(
                            onTap: () {
                              menuRead.clearReasonText();
                              openQtyDialog(
                                  context, menuWatch, menuRead, index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Constants().screenWidth(context) * 0.03,
                              child: AppTextStyle().textBold(
                                  menuWatch.transactionModel!.responseObj!
                                      .orderList![index].qty!
                                      .toInt()
                                      .toString(),
                                  size:
                                      Constants().screenheight(context) * 0.02),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => menuRead.manageCountOrder(
                                context, index, 'add'),
                            child: Icon(Icons.add_box_outlined,
                                color: Constants.primaryColor,
                                size:
                                    Constants().screenheight(context) * 0.045),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      Constants().screenheight(context) * 0.01),
                              width: Constants().screenWidth(context) * 0.155,
                              child: AppTextStyle().textBold(
                                  menuWatch.transactionModel!.responseObj!
                                      .orderList![index].itemName!,
                                  size: Constants().screenheight(context) *
                                      0.023)),
                          const Spacer(),
                          Container(
                              alignment: Alignment.centerRight,
                              width: Constants().screenWidth(context) * 0.06,
                              child: AppTextStyle().textBold(
                                  menuWatch.transactionModel!.responseObj!
                                      .orderList![index].retailPrice!
                                      .toString(),
                                  size: Constants().screenheight(context) *
                                      0.023)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

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
