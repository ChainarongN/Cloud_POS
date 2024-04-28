import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Row couponList(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          // LoadingStyle().dialogLoadding(context);
          // menuRead.orderSummary(context).then((value) {
          //   if (menuWatch.apiState == ApiState.COMPLETED) {
          // Navigator.maybePop(context).then((value) {
          menuRead.clearField();
          eCouponDialog(context);
          //     });
          //   }
          // });
        },
        child: Container(
          width: Constants().screenWidth(context) * 0.09,
          height: Constants().screenheight(context) * 0.084,
          padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Constants.primaryColor),
            color: Constants.secondaryColor,
            boxShadow: const [
              BoxShadow(
                  color: Constants.primaryColor,
                  blurRadius: 8,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.local_attraction,
                    color: Colors.black54,
                    size: Constants().screenheight(context) * 0.03),
                AppTextStyle().textNormal('e-Coupon'),
              ],
            ),
          ),
        ),
      ),
      Container(
        width: Constants().screenWidth(context) * 0.09,
        height: Constants().screenheight(context) * 0.084,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Constants.secondaryColor,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.percent,
                  color: Colors.black54,
                  size: Constants().screenheight(context) * 0.028),
              AppTextStyle().textNormal(LocaleKeys.discount_other.tr()),
            ],
          ),
        ),
      ),
      Container(
        width: Constants().screenWidth(context) * 0.09,
        height: Constants().screenheight(context) * 0.084,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Constants.secondaryColor,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.discount,
                  color: Colors.black54,
                  size: Constants().screenheight(context) * 0.028),
              AppTextStyle().textNormal(LocaleKeys.discount.tr()),
            ],
          ),
        ),
      ),
    ],
  );
}

Future<dynamic> eCouponInquiryDialog(
    BuildContext context, MenuProvider menuPvd) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(Constants().screenheight(context) * 0.01),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: Constants().screenheight(context) * 0.02),
                        child: Icon(Icons.local_attraction,
                            size: Constants().screenheight(context) * 0.06),
                      ),
                      AppTextStyle().textNormal(
                          LocaleKeys.voucher_information.tr(),
                          size: Constants().screenheight(context) * 0.03),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01,
                        bottom: Constants().screenheight(context) * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenheight(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold(
                                    LocaleKeys.voucher_id.tr(),
                                    size: Constants().screenheight(context) *
                                        0.024),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .voucherID
                                        .toString(),
                                    size: Constants().screenheight(context) *
                                        0.024)
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                                Constants().screenheight(context) * 0.018),
                            child: Column(
                              children: <Widget>[
                                AppTextStyle().textBold(
                                    LocaleKeys.coupon_system.tr(),
                                    size: Constants().screenheight(context) *
                                        0.024),
                                AppTextStyle().textNormal(
                                    menuPvd.couponInquiryModel!.responseObj!
                                        .couponSystem!,
                                    size: Constants().screenheight(context) *
                                        0.023)
                              ],
                            ),
                          ),
                        ),
                        ClipOval(
                            child: SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          height: Constants().screenheight(context) * 0.12,
                          child: Image.network(
                            menuPvd.couponInquiryModel!.responseObj!.imageUrl!,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Constants().screenheight(context) * 0.012,
                          bottom: Constants().screenheight(context) * 0.012,
                          left: Constants().screenheight(context) * 0.035,
                          right: Constants().screenheight(context) * 0.035),
                      child: Column(
                        children: <Widget>[
                          AppTextStyle().textBold(
                              LocaleKeys.voucher_status.tr(),
                              size: Constants().screenheight(context) * 0.024),
                          AppTextStyle().textNormal(
                              menuPvd
                                  .couponInquiryModel!.responseObj!.resultText!,
                              size: Constants().screenheight(context) * 0.024,
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
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.voucher.tr()} S/N : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.voucherSN!
                                    .isNotEmpty
                                ? menuPvd
                                    .couponInquiryModel!.responseObj!.voucherSN!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.voucher_name.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherName!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.promotion_code.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionCode!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.promotion_name.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .promotionName!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.voucher_amount.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherAmount!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.voucher_value.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!.isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .voucherValue!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Constants().screenheight(context) * 0.01),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Constants().screenWidth(context) * 0.12,
                          child: AppTextStyle().textBold(
                              '${LocaleKeys.expire_date.tr()} : ',
                              size: Constants().screenheight(context) * 0.023),
                        ),
                        AppTextStyle().textNormal(
                            menuPvd.couponInquiryModel!.responseObj!.expireDate!
                                    .isNotEmpty
                                ? menuPvd.couponInquiryModel!.responseObj!
                                    .expireDate!
                                : '-',
                            size: Constants().screenheight(context) * 0.023)
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
                  size: Constants().screenheight(context) * 0.03,
                  color:
                      menuPvd.couponInquiryModel!.responseObj!.voucherStatus !=
                              1
                          ? Colors.grey.shade400
                          : Colors.blueAccent),
              onPressed: () async {
                if (menuPvd.couponInquiryModel!.responseObj!.voucherStatus ==
                    1) {
                  LoadingStyle().dialogLoadding(context);
                  menuPvd.eCouponApply(context).then((value) {
                    if (menuPvd.apiState == ApiState.COMPLETED) {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    }
                  });
                }
              },
            ),
            TextButton(
              child: AppTextStyle().textNormal(LocaleKeys.close.tr(),
                  size: Constants().screenheight(context) * 0.03,
                  color: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Future<void> eCouponDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Consumer<MenuProvider>(
      builder: (context, dataProvider, child) => AlertDialog(
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: Constants().screenheight(context) * 0.02,
                  left: Constants().screenheight(context) * 0.03),
              child: Icon(Icons.local_attraction,
                  size: Constants().screenheight(context) * 0.065),
            ),
            AppTextStyle().textNormal(
                '${LocaleKeys.coupon.tr()} / ${LocaleKeys.promotion.tr()}',
                size: Constants().screenheight(context) * 0.03),
            const Spacer(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: Constants().screenheight(context) * 0.02),
                  width: Constants().screenWidth(context) * 0.3,
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
                        fontSize: Constants().screenheight(context) * 0.024),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: Constants().screenheight(context) * 0.05),
                  width: Constants().screenWidth(context) * 0.1,
                  height: Constants().screenheight(context) * 0.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 157, 198, 255),
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (dataProvider.couponCodeController.text.isNotEmpty) {
                          LoadingStyle().dialogLoadding(context);
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
                      child: AppTextStyle().textBold(LocaleKeys.ok.tr(),
                          size: Constants().screenheight(context) * 0.034,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
        content: SizedBox(
            width: Constants().screenWidth(context),
            height: Constants().screenheight(context),
            child: dataProvider
                    .transactionModel!.responseObj!.promoList!.isEmpty
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.promotion_code.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.promotion_name.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.delete.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      Constants().screenheight(context) * 0.16,
                                  child: dataProvider.transactionModel!
                                          .responseObj!.promoList!.isEmpty
                                      ? const SizedBox.shrink()
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              dataProvider
                                                  .transactionModel!
                                                  .responseObj!
                                                  .promoList!
                                                  .length,
                                              (indexOutside) => dataProvider
                                                      .transactionModel!
                                                      .responseObj!
                                                      .promoList![indexOutside]
                                                      .couponList!
                                                      .isEmpty
                                                  ? const SizedBox.shrink()
                                                  : showCouponData(dataProvider,
                                                      indexOutside, context),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.product_name.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.qty.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.price.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.total_price.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.disc_qty.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.promo_disc.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.sales_prices.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.promotion_name.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      Constants().screenheight(context) * 0.25,
                                  child: dataProvider.transactionModel!
                                          .responseObj!.promoList!.isEmpty
                                      ? const SizedBox.shrink()
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              dataProvider
                                                  .transactionModel!
                                                  .responseObj!
                                                  .orderList!
                                                  .length,
                                              (index) => dataProvider
                                                      .transactionModel!
                                                      .responseObj!
                                                      .orderList![index]
                                                      .promoItemList!
                                                      .isEmpty
                                                  ? const SizedBox.shrink()
                                                  : showOrderFromCoupon(
                                                      dataProvider,
                                                      index,
                                                      context),
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          Constants().screenheight(context) *
                                              0.025),
                                  child: AppTextStyle().textBold(
                                      'Promotion Summary',
                                      size: Constants().screenheight(context) *
                                          0.025),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            LocaleKeys.promotion_name.tr(),
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            'Coupon/Voucher No.',
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: AppTextStyle().textBold(
                                            'Discount Amount',
                                            size: Constants()
                                                    .screenheight(context) *
                                                0.024),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      Constants().screenheight(context) * 0.16,
                                  child: dataProvider.transactionModel!
                                          .responseObj!.promoList!.isEmpty
                                      ? const SizedBox.shrink()
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              dataProvider
                                                  .transactionModel!
                                                  .responseObj!
                                                  .promoList!
                                                  .length,
                                              (index) => dataProvider
                                                      .transactionModel!
                                                      .responseObj!
                                                      .promoList![index]
                                                      .couponList!
                                                      .isEmpty
                                                  ? const SizedBox.shrink()
                                                  : showPromotionSum(
                                                      dataProvider,
                                                      index,
                                                      context),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(
              LocaleKeys.close.tr(),
              size: Constants().screenheight(context) * 0.03,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

Column showPromotionSum(
    MenuProvider dataProvider, int index, BuildContext context) {
  return Column(
    children: [
      const Divider(thickness: 0.3),
      Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.promoList![index]
                      .promotionName!,
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                dataProvider.transactionModel!.responseObj!.promoList![index]
                    .couponList!
                    .map((item) => item.couponNumber!)
                    .toList()
                    .join(", "),
                style: TextStyle(
                    fontSize: Constants().screenheight(context) * 0.024),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.promoList![index]
                      .totalDiscount
                      .toString(),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
        ],
      ),
    ],
  );
}

Column showCouponData(
    MenuProvider dataProvider, int indexOutside, BuildContext context) {
  return Column(
    children: List.generate(
      dataProvider.transactionModel!.responseObj!.promoList![indexOutside]
          .couponList!.length,
      (indexInside) => Column(
        children: [
          const Divider(thickness: 0.3),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: AppTextStyle().textNormal(
                      dataProvider
                          .transactionModel!
                          .responseObj!
                          .promoList![indexOutside]
                          .couponList![indexInside]
                          .couponNumber!,
                      size: Constants().screenheight(context) * 0.024),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: AppTextStyle().textNormal(
                      dataProvider.transactionModel!.responseObj!
                          .promoList![indexOutside].promotionName!,
                      size: Constants().screenheight(context) * 0.024),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      LoadingStyle().dialogLoadding(context);
                      dataProvider
                          .promotionCancel(context, indexOutside, indexInside)
                          .then((value) {
                        if (dataProvider.apiState == ApiState.COMPLETED) {
                          Navigator.maybePop(context);
                        }
                      });
                    },
                    child: Icon(Icons.delete,
                        color: Colors.red,
                        size: Constants().screenheight(context) * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Column showOrderFromCoupon(
    MenuProvider dataProvider, int index, BuildContext context) {
  return Column(
    children: [
      const Divider(thickness: 0.3),
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.orderList![index]
                      .itemName!,
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider
                      .transactionModel!.responseObj!.orderList![index].qty!
                      .toInt()
                      .toString(),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.orderList![index]
                      .unitPrice
                      .toString(),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.orderList![index]
                      .retailPrice
                      .toString(),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.transactionModel!.responseObj!.orderList![index]
                      .promoItemList!.length
                      .toString(),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.sumTotalDiscountCoupon(index, 'totalDis'),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: AppTextStyle().textNormal(
                  dataProvider.sumTotalDiscountCoupon(index, 'salesPrice'),
                  size: Constants().screenheight(context) * 0.024),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
                child: Text(
              dataProvider.transactionModel!.responseObj!.orderList![index]
                  .promoItemList!
                  .map((item) => item.promotionName)
                  .toList()
                  .join(", "),
              style: TextStyle(
                  fontSize: Constants().screenheight(context) * 0.024),
            )),
          ),
        ],
      )
    ],
  );
}
