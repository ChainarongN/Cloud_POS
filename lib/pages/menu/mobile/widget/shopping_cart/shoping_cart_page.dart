import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/manage_menu/order_detail_mobile.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/manage_menu/order_list_mobile.dart';
import 'package:cloud_pos/providers/menu/functions/payment_func.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:cloud_pos/utils/widgets/receipt_bill_print.dart';
import 'package:flutter/material.dart';
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
            List<PayTypeInfo> resultSelect = menuWatch.payTypeInfoList!
                .where((element) =>
                    element.payTypeID == menuWatch.getValuePaytypeIdSelect)
                .toList();
            PaymentFunc().paymentDinamic(context,
                payTypeId: resultSelect.first.payTypeID,
                edcType: resultSelect.first.eDCType,
                payTypeCode: resultSelect.first.payTypeCode,
                payTypeName: resultSelect.first.payTypeName,
                payTypeFlow: resultSelect.first.payTypeFlow,
                payRemark: '',
                menuRead: menuRead,
                menuWatch: menuWatch);
          },
          child: Center(
            child: AppTextStyle().textBold('Payment',
                size: Constants().screenWidth(context) * Constants.boldSizeMB,
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
                    size: Constants().screenWidth(context) *
                        Constants.boldSizeMB),
              ),
              orderListMobile(menuWatch, menuRead, context),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    AppTextStyle().textBold('ทั้งหมด',
                        size: Constants().screenWidth(context) *
                            Constants.boldSizeMB),
                    const Spacer(),
                    Container(
                      child: menuWatch.transactionModel!.responseCode!.isEmpty
                          ? AppTextStyle().textBold(
                              menuWatch.transactionModel!.responseObj!.dueAmount
                                  .toString(),
                              size: Constants().screenWidth(context) *
                                  Constants.boldSizeMB)
                          : AppTextStyle().textBold(
                              '0.00',
                              size: Constants().screenWidth(context) *
                                  Constants.boldSizeMB,
                            ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              cardTitle(context,
                  title: 'e-Coupon',
                  subTitle: menuWatch
                          .transactionModel!.responseObj!.promoList!.isNotEmpty
                      ? '${menuWatch.transactionModel!.responseObj!.promoList!.length} Coupon'
                      : 'ใช้คูปอง', onTap: () {
                Navigator.pushNamed(context, '/eCouponPage');
              }),
              menuWatch.propertyInfo.contains('Discount')
                  ? cardTitle(context,
                      title: 'Discount', subTitle: 'ใช้ส่วนลด', onTap: () {})
                  : const SizedBox.shrink(),
              cardTitle(context, title: 'Order summary', subTitle: '',
                  onTap: () async {
                DialogStyle().dialogLoadding(context);
                await menuRead.orderSummary(context).then((value) {
                  if (menuWatch.apiState == ApiState.COMPLETED) {
                    Navigator.pop(context);
                    showOrderSumDialog(context, menuWatch.getHtmlOrderSummary,
                        menuWatch.screenshotOrderSumController);
                  }
                });
              }),
              Divider(thickness: 1, color: Colors.grey.shade300),
              orderDetailMobile(context, menuWatch),
              Divider(thickness: 1, color: Colors.grey.shade300),
              AppTextStyle().textBold('ชำระเงินโดย',
                  size:
                      Constants().screenWidth(context) * Constants.boldSizeMB),
              GestureDetector(
                onTap: () {
                  selectPayTypeDialog(context, menuWatch, menuRead);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: Constants().screenheight(context) * 0.01,
                      left: Constants().screenWidth(context) * 0.055,
                      bottom: Constants().screenheight(context) * 0.13),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        AppTextStyle().textNormal(
                            menuWatch.payTypeInfoList!
                                .where((element) =>
                                    element.payTypeID ==
                                    menuWatch.getValuePaytypeIdSelect)
                                .first
                                .payTypeName!,
                            size: Constants().screenWidth(context) *
                                Constants.boldSizeMB),
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
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectPayTypeDialog(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
              height: Constants().screenheight(context) * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    menuWatch.payTypeInfoList!.length,
                    (index) => !menuWatch.resultPayTypeList!.contains(menuWatch
                            .payTypeInfoList![index].payTypeID
                            .toString())
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              menuRead
                                  .setValuePayTypeSelect(menuWatch
                                      .payTypeInfoList![index].payTypeID!)
                                  .then((value) => Navigator.pop(context));
                            },
                            child: SizedBox(
                              height: Constants().screenheight(context) * 0.08,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: AppTextStyle().textBold(
                                      menuWatch
                                          .payTypeInfoList![index].payTypeName!,
                                      size: Constants().screenWidth(context) *
                                          Constants.normalSizeMB,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              )),
          actions: <Widget>[
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

  GestureDetector cardTitle(
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
                  size: Constants().screenWidth(context) *
                      Constants.normalSizeMB),
              const Spacer(),
              AppTextStyle().textBold(subTitle!,
                  size:
                      Constants().screenWidth(context) * Constants.normalSizeMB,
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
