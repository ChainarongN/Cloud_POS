import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/manage_menu/order_detail_mobile.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/manage_menu/order_list_mobile.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ShopingCartPage extends StatefulWidget {
  const ShopingCartPage({super.key});

  @override
  State<ShopingCartPage> createState() => _ShopingCartPageState();
}

class _ShopingCartPageState extends State<ShopingCartPage> {
  @override
  Widget build(BuildContext context) {
    var menuWatch = context.watch<MenuProvider>();
    var menuRead = context.read<MenuProvider>();
    return Scaffold(
      appBar: AppBar(title: AppTextStyle().textNormal('Shoping cart')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor),
          onPressed: () {
            openPayAmountDialog(context, menuWatch, menuRead);
          },
          child: Center(
            child: AppTextStyle().textBold('Payment',
                size: Constants().screenWidth(context) * Constants.boldSize,
                color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: Constants().screenheight(context) * 0.015),
                child: AppTextStyle().textBold('Order List',
                    size:
                        Constants().screenWidth(context) * Constants.boldSize),
              ),
              orderListMobile(menuWatch, menuRead, context),
              Row(
                children: [
                  AppTextStyle().textBold('ทั้งหมด',
                      size: Constants().screenWidth(context) *
                          Constants.boldSize),
                  const Spacer(),
                  Container(
                    child: menuWatch.transactionModel!.responseCode!.isEmpty
                        ? AppTextStyle().textBold(
                            menuWatch.transactionModel!.responseObj!.dueAmount
                                .toString(),
                            size: Constants().screenWidth(context) *
                                Constants.boldSize)
                        : AppTextStyle().textBold(
                            '0.00',
                            size: Constants().screenWidth(context) *
                                Constants.boldSize,
                          ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              cardMenu(context,
                  title: 'e-Coupon', subTitle: 'ใช้คูปอง', onTap: () {}),
              cardMenu(context,
                  title: 'Discount', subTitle: 'ใช้ส่วนลด', onTap: () {}),
              cardMenu(context,
                  title: 'Discount other', subTitle: 'ใช้ส่วนลด', onTap: () {}),
              cardMenu(context,
                  title: 'Order summary', subTitle: '', onTap: () {}),
              Divider(thickness: 1, color: Colors.grey.shade300),
              orderDetailMobile(context, menuWatch),
              Divider(thickness: 1, color: Colors.grey.shade300),
              AppTextStyle().textBold('ชำระเงินโดย',
                  size: Constants().screenWidth(context) * Constants.boldSize),
              Container(
                margin: EdgeInsets.only(
                    top: Constants().screenheight(context) * 0.01,
                    left: Constants().screenWidth(context) * 0.055,
                    bottom: Constants().screenheight(context) * 0.13),
                child: Row(
                  children: [
                    AppTextStyle().textNormal('เงินสด',
                        size: Constants().screenWidth(context) *
                            Constants.boldSize),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                          left: Constants().screenWidth(context) * 0.015),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: Constants().screenWidth(context) * 0.04,
                      ),
                    )
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openPayAmountDialog(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: Constants().screenheight(context) * 0.15,
            child: Column(
              children: <Widget>[
                Container(
                  // width: Constants().screenWidth(context) * 0.2,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Payment amount',
                      border: Constants().myinputborder(), //normal border
                      enabledBorder:
                          Constants().myinputborder(), //enabled border
                      focusedBorder:
                          Constants().myfocusborder(), //focused border
                    ),
                    style: TextStyle(
                        color: Constants.textColor,
                        fontSize: Constants().screenheight(context) * 0.025),
                    onChanged: (value) {
                      menuRead.payAmount = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: AppTextStyle().textNormal('OK', size: 18),
              onPressed: () async {
                if (menuWatch.payAmount!.isNotEmpty) {
                  menuRead.paymentCash(
                      context: context, payAmount: menuWatch.payAmount);
                }
              },
            ),
            TextButton(
              child: AppTextStyle()
                  .textNormal('Cancel', size: 18, color: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  GestureDetector cardMenu(
    BuildContext context, {
    String? title,
    String? subTitle,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Constants().screenheight(context) * 0.015),
          child: Row(
            children: [
              AppTextStyle().textBold(title!,
                  size:
                      Constants().screenWidth(context) * Constants.normalSize),
              const Spacer(),
              AppTextStyle().textBold(subTitle!,
                  size: Constants().screenWidth(context) * Constants.normalSize,
                  color: Colors.grey),
              Container(
                margin: EdgeInsets.only(
                    left: Constants().screenWidth(context) * 0.015),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: Constants().screenWidth(context) * 0.04,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
