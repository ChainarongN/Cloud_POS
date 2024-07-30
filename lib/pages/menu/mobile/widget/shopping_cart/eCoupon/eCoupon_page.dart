import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/eCoupon/coupon_data_tab.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/eCoupon/coupon_order_tab.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/shopping_cart/eCoupon/coupon_sum_tab.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:cloud_pos/utils/widgets/scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ECouponPage extends StatefulWidget {
  const ECouponPage({super.key});

  @override
  State<ECouponPage> createState() => _ECouponPageState();
}

class _ECouponPageState extends State<ECouponPage> {
  @override
  Widget build(BuildContext context) {
    var menuWatch = context.watch<MenuProvider>();
    var menuRead = context.read<MenuProvider>();
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: AppTextStyle().textNormal('e-Coupon'),
          actions: [
            GestureDetector(
              onTap: () {
                addCouponDialog(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                    right: Constants().screenWidth(context) * 0.06),
                child: Icon(Icons.add_card_rounded,
                    size: Constants().screenWidth(context) * 0.08),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Coupon Data',
              ),
              Tab(
                text: 'Order',
              ),
              Tab(
                text: 'Promotion sum',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      menuWatch
                          .transactionModel!.responseObj!.promoList!.length,
                      (indexOutside) => menuWatch.transactionModel!.responseObj!
                              .promoList![indexOutside].couponList!.isEmpty
                          ? const SizedBox.shrink()
                          : showCouponData(menuWatch, indexOutside, context),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      menuWatch
                          .transactionModel!.responseObj!.orderList!.length,
                      (index) => menuWatch.transactionModel!.responseObj!
                              .orderList![index].promoItemList!.isEmpty
                          ? const SizedBox.shrink()
                          : showOrderFromCoupon(menuWatch, index, context),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      menuWatch
                          .transactionModel!.responseObj!.promoList!.length,
                      (index) => menuWatch.transactionModel!.responseObj!
                              .promoList![index].couponList!.isEmpty
                          ? const SizedBox.shrink()
                          : showPromotionSum(menuWatch, index, context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addCouponDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Consumer<MenuProvider>(
        builder: (context, dataProvider, child) => AlertDialog(
          content: SizedBox(
            // height: Constants().screenheight(context) * 0.18,
            child: Padding(
              padding: EdgeInsets.all(Constants().screenWidth(context) * 0.015),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: Constants().screenWidth(context) * 0.02),
                        child: Icon(Icons.local_attraction,
                            size: Constants().screenWidth(context) * 0.07),
                      ),
                      AppTextStyle().textBold(
                          '${LocaleKeys.coupon.tr()} / ${LocaleKeys.promotion.tr()}',
                          size: Constants().screenWidth(context) *
                              Constants.normalSize),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.02),
                    child: TextField(
                      controller: dataProvider.couponCodeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        labelText: LocaleKeys.promotion_code.tr(),
                        border: Constants().myinputborder(), //normal border
                        enabledBorder:
                            Constants().myinputborder(), //enabled border
                        focusedBorder:
                            Constants().myfocusborder(), //focused border
                      ),
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: Constants().screenWidth(context) *
                              Constants.normalSize),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QRViewExample(),
                        ));
                      },
                      child: AppTextStyle().textBold('Scan',
                          size: Constants().screenWidth(context) *
                              Constants.normalSize,
                          color: Constants.primaryColor))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                  size: Constants().screenWidth(context) * Constants.normalSize,
                  color: Constants.primaryColor),
              onPressed: () async {
                if (dataProvider.couponCodeController.text.isNotEmpty) {
                  DialogStyle().dialogLoadding(context);
                  dataProvider.eCouponInquiry(context).then((value) {
                    if (dataProvider.apiState == ApiState.COMPLETED) {
                      dataProvider.clearField();
                      Navigator.maybePop(context).then((value) {
                        eCouponInquiryDialog(context, dataProvider);
                      });
                    }
                  });
                }
              },
              onLongPress: () {
                dataProvider.setCouponCodeControllerForTest();
              },
            ),
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                  size: Constants().screenWidth(context) * Constants.normalSize,
                  color: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> eCouponInquiryDialog(
    BuildContext context, MenuProvider menuPvd) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: Constants().screenWidth(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: Constants().screenWidth(context) * 0.02),
                          child: Icon(Icons.local_attraction,
                              size: Constants().screenWidth(context) * 0.07),
                        ),
                        AppTextStyle().textNormal(
                            LocaleKeys.voucher_information.tr(),
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                      ],
                    ),
                  ),
                  Center(
                    child: ClipOval(
                        child: Image.network(
                      menuPvd.couponInquiryModel!.responseObj!.imageUrl!,
                      width: Constants().screenWidth(context) * 0.4,
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01,
                        bottom: Constants().screenheight(context) * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenWidth(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold(
                                    LocaleKeys.voucher_id.tr(),
                                    size: Constants().screenWidth(context) *
                                        Constants.normalSize),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .voucherID
                                        .toString(),
                                    size: Constants().screenWidth(context) *
                                        Constants.normalSize)
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenWidth(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold(
                                    LocaleKeys.coupon_system.tr(),
                                    size: Constants().screenWidth(context) *
                                        Constants.normalSize),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .couponSystem!,
                                    size: Constants().screenWidth(context) *
                                        Constants.normalSize)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Constants().screenheight(context) * 0.012,
                          bottom: Constants().screenheight(context) * 0.012,
                          left: Constants().screenWidth(context) * 0.035,
                          right: Constants().screenWidth(context) * 0.035),
                      child: Column(
                        children: <Widget>[
                          AppTextStyle().textBold(
                              LocaleKeys.voucher_status.tr(),
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize),
                          AppTextStyle().textNormal(
                              menuPvd
                                  .couponInquiryModel!.responseObj!.resultText!,
                              size: Constants().screenWidth(context) *
                                  Constants.normalSize,
                              color: menuPvd.couponInquiryModel!.responseObj!
                                          .voucherStatus ==
                                      1
                                  ? Colors.green
                                  : Colors.red)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.018),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.voucher.tr()} S/N :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.voucherSN!
                                    .isNotEmpty
                                ? menuPvd
                                    .couponInquiryModel!.responseObj!.voucherSN!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.voucher_name.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.promotion_code.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.promotion_name.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.voucher_amount.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.voucher_value.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTextStyle().textBold(
                            '${LocaleKeys.expire_date.tr()} :',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.expireDate!
                                    .isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .expireDate!
                                : '-',
                            size: Constants().screenWidth(context) *
                                Constants.normalSize)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.apply.tr(),
                  size: Constants().screenWidth(context) * Constants.normalSize,
                  color:
                      menuPvd.couponInquiryModel!.responseObj!.voucherStatus !=
                              1
                          ? Colors.grey.shade400
                          : Colors.blueAccent),
              onPressed: () async {
                if (menuPvd.couponInquiryModel!.responseObj!.voucherStatus ==
                    1) {
                  DialogStyle().dialogLoadding(context);
                  menuPvd.eCouponApply(context).then((value) {
                    if (menuPvd.apiState == ApiState.COMPLETED) {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName("/eCouponPage"));
                    }
                  });
                }
              },
            ),
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.close.tr(),
                  size: Constants().screenWidth(context) * Constants.normalSize,
                  color: Colors.red),
              onPressed: () async {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/eCouponPage"));
              },
            ),
          ],
        );
      });
}
