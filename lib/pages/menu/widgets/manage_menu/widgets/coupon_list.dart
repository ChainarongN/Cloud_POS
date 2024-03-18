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
                      AppTextStyle().textNormal('Voucher Information',
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
                                AppTextStyle().textBold('Voucher ID',
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
                                AppTextStyle().textBold('Coupon System',
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
                          AppTextStyle().textBold('Voucher Status',
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
                          child: AppTextStyle().textBold('Voucher S/N : ',
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
                          child: AppTextStyle().textBold('Voucher Name : ',
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
                          child: AppTextStyle().textBold('Promotion Code : ',
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
                          child: AppTextStyle().textBold('Promotion Name : ',
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
                          child: AppTextStyle().textBold('Voucher Amount : ',
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
                          child: AppTextStyle().textBold('Voucher Value : ',
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
                          child: AppTextStyle().textBold('Expire Date : ',
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
              child: AppTextStyle().textNormal('Apply',
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
                  right: Constants().screenheight(context) * 0.02),
              child: Icon(Icons.local_attraction,
                  size: Constants().screenheight(context) * 0.065),
            ),
            AppTextStyle().textNormal('Coupon / Promotion',
                size: Constants().screenheight(context) * 0.03),
            const Spacer(),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: Constants().screenWidth(context) * 0.3,
                  child: TextField(
                    controller: dataProvider.getcouponCodeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      labelText: 'รหัสบัตร',
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
                SizedBox(
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
                        LoadingStyle().dialogLoadding(context);
                        dataProvider.eCouponInquiry(context).then((value) {
                          if (dataProvider.apiState == ApiState.COMPLETED) {
                            Navigator.maybePop(context).then((value) {
                              eCouponInquiryDialog(context, dataProvider);
                            });
                          }
                        });
                      },
                      child: AppTextStyle().textBold('OK',
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
            child: SingleChildScrollView(
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
                                      'หมายเลขบัตรกำนัล',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold(
                                      'ชื่อโปรโมชั่น',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('ลบ',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Constants().screenheight(context) * 0.16,
                            child:
                                dataProvider.couponApplyModel == null ||
                                        dataProvider.couponApplyModel!
                                            .responseCode!.isNotEmpty
                                    ? const SizedBox.shrink()
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(
                                              dataProvider
                                                  .couponApplyModel!
                                                  .responseObj!
                                                  .promoList!
                                                  .length,
                                              (indexOutside) =>
                                                  dataProvider
                                                          .couponApplyModel!
                                                          .responseObj!
                                                          .promoList![
                                                              indexOutside]
                                                          .couponList!
                                                          .isEmpty
                                                      ? const SizedBox.shrink()
                                                      : Column(
                                                          children:
                                                              List.generate(
                                                            dataProvider
                                                                .couponApplyModel!
                                                                .responseObj!
                                                                .promoList![
                                                                    indexOutside]
                                                                .couponList!
                                                                .length,
                                                            (indexInside) =>
                                                                Column(
                                                              children: [
                                                                const Divider(
                                                                    thickness:
                                                                        0.3),
                                                                Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Center(
                                                                        child: AppTextStyle().textNormal(
                                                                            dataProvider.couponApplyModel!.responseObj!.promoList![indexOutside].couponList![indexInside].couponNumber!,
                                                                            size: Constants().screenheight(context) * 0.024),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Center(
                                                                        child: AppTextStyle().textNormal(
                                                                            dataProvider.couponApplyModel!.responseObj!.promoList![indexOutside].promotionName!,
                                                                            size: Constants().screenheight(context) * 0.024),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            LoadingStyle().dialogLoadding(context);
                                                                            dataProvider.promotionCancel(context, indexOutside, indexInside).then((value) {
                                                                              if (dataProvider.apiState == ApiState.COMPLETED) {
                                                                                Navigator.maybePop(context);
                                                                              }
                                                                            });
                                                                          },
                                                                          child: Icon(
                                                                              Icons.delete,
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
                                                        )),
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
                                  child: AppTextStyle().textBold('Product Name',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('Qty',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Total Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: AppTextStyle().textBold('Disc Qty',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Promo Disc',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: AppTextStyle().textBold('Sales Price',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: AppTextStyle().textBold(
                                      'Promotion Name',
                                      size: Constants().screenheight(context) *
                                          0.024),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Constants().screenheight(context) * 0.3,
                            child:
                                dataProvider.couponApplyModel == null ||
                                        dataProvider.couponApplyModel!
                                            .responseCode!.isNotEmpty
                                    ? const SizedBox.shrink()
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(
                                            dataProvider.couponApplyModel!
                                                .responseObj!.orderList!.length,
                                            (index) =>
                                                dataProvider
                                                        .couponApplyModel!
                                                        .responseObj!
                                                        .orderList![index]
                                                        .promoItemList!
                                                        .isEmpty
                                                    ? const SizedBox.shrink()
                                                    : Column(
                                                        children: [
                                                          const Divider(
                                                              thickness: 0.3),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 3,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider
                                                                          .couponApplyModel!
                                                                          .responseObj!
                                                                          .orderList![
                                                                              index]
                                                                          .itemName!,
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider
                                                                          .couponApplyModel!
                                                                          .responseObj!
                                                                          .orderList![
                                                                              index]
                                                                          .qty!
                                                                          .toInt()
                                                                          .toString(),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider
                                                                          .couponApplyModel!
                                                                          .responseObj!
                                                                          .orderList![
                                                                              index]
                                                                          .unitPrice
                                                                          .toString(),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider
                                                                          .couponApplyModel!
                                                                          .responseObj!
                                                                          .orderList![
                                                                              index]
                                                                          .retailPrice
                                                                          .toString(),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider
                                                                          .couponApplyModel!
                                                                          .responseObj!
                                                                          .orderList![
                                                                              index]
                                                                          .promoItemList!
                                                                          .length
                                                                          .toString(),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider.sumTotalDiscountCoupon(
                                                                          index,
                                                                          'totalDis'),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      dataProvider.sumTotalDiscountCoupon(
                                                                          index,
                                                                          'salesPrice'),
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Center(
                                                                  child: AppTextStyle().textNormal(
                                                                      '${dataProvider.couponApplyModel!.responseObj!.orderList![index].promoItemList!.first.promotionName} (${dataProvider.getWhereCouponId(dataProvider.couponApplyModel!.responseObj!.orderList![index].promoItemList!.first.promotionID!)})',
                                                                      size: Constants()
                                                                              .screenheight(context) *
                                                                          0.024),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                          ),
                                        ),
                                      ),
                          )
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
