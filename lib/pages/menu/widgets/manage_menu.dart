import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Card manageMenu(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Card(
    child: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              orderTitle(menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderList(menuWatch, menuRead, context),
              Divider(thickness: 2, color: Colors.grey.shade300),
              orderDetail(context, menuWatch),
              Divider(thickness: 2, color: Colors.grey.shade300),
              couponList(context),
              binButton(context),
              priceList(context, menuRead)
            ],
          ),
        ),
      ),
    ),
  );
}

Row priceList(BuildContext context, MenuProvider menuRead) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          menuRead.payment(context: context, payAmount: '50');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.065,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Constants.primaryColor,
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
                AppTextStyle().textBold('50', size: 25),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.payment(context: context, payAmount: '100');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.065,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.red.shade400,
            boxShadow: const [
              BoxShadow(color: Colors.red, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('100', size: 25),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.payment(context: context, payAmount: '500');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.065,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.purple.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.purple, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('500', size: 25),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          menuRead.payment(context: context, payAmount: '1000');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.065,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 8, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppTextStyle().textBold('1000', size: 25),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Row binButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Colors.blue.shade800,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.receipt_long, color: Colors.white, size: 45.0),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.085,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.primaryColor),
          color: Colors.blue.shade800,
          boxShadow: const [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 8,
                offset: Offset(0, 6)),
          ],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.local_printshop_rounded,
                  color: Colors.white, size: 45.0),
            ],
          ),
        ),
      ),
    ],
  );
}

Row couponList(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 0.09,
        height: MediaQuery.of(context).size.height * 0.08,
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
              const Icon(Icons.adb_rounded, color: Colors.black54, size: 20.0),
              AppTextStyle().textNormal('e-Coupon'),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.09,
        height: MediaQuery.of(context).size.height * 0.08,
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
              const Icon(Icons.adb_rounded, color: Colors.black54, size: 20.0),
              AppTextStyle().textNormal('ส่วนลด อื่นๆ'),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.09,
        height: MediaQuery.of(context).size.height * 0.08,
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
              const Icon(Icons.adb_rounded, color: Colors.black54, size: 20.0),
              AppTextStyle().textNormal('ส่วนลด'),
            ],
          ),
        ),
      ),
    ],
  );
}

Row orderDetail(BuildContext context, MenuProvider menuWatch) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Total Qty:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.totalQty!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Total Discount:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.totalDiscount!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Service Charge:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.serviceCharge!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Other Income:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Tax 7.00%:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.vATPercent!
                        .toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width * 0.15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Sub Total:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Grand Total:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Rounding:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.roundingBill!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Pay Amount:'),
                const Spacer(),
                menuWatch.productAddModel == null ||
                        menuWatch.productAddModel!.responseCode!.isNotEmpty ||
                        menuWatch
                            .productAddModel!.responseObj!.orderList!.isEmpty
                    ? AppTextStyle().textNormal('-')
                    : AppTextStyle().textNormal(menuWatch
                        .productAddModel!.responseObj!.payAmount!
                        .toStringAsFixed(2)),
              ],
            ),
            Row(
              children: <Widget>[
                AppTextStyle().textNormal('Before Tex:'),
                const Spacer(),
                AppTextStyle().textNormal('-'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

SizedBox orderList(
    MenuProvider menuWatch, MenuProvider menuRead, BuildContext context) {
  return menuWatch.productAddModel == null ||
          menuWatch.productAddModel!.responseCode!.isNotEmpty ||
          menuWatch.productAddModel!.responseObj!.orderList!.isEmpty
      ? SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Center(child: AppTextStyle().textNormal('There is no menu.')),
        )
      : SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView(
            children: [
              Column(
                children: List.generate(
                  menuWatch.productAddModel!.responseObj!.orderList!.length,
                  (index) => Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: AppTextStyle().textNormal(menuWatch
                                        .productAddModel!
                                        .responseObj!
                                        .orderList![index]
                                        .itemName!),
                                    content: TextField(
                                      onChanged: (value) {},
                                      decoration: const InputDecoration(
                                          hintText: "Input your remark"),
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textNormal(
                                            'Cancel',
                                            color: Colors.red),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AppTextStyle().textBold('OK',
                                            color: Constants.primaryColor),
                                      ),
                                    ],
                                  );
                                });
                          },
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Remark',
                        ),
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) {},
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      margin: const EdgeInsets.only(bottom: 5, right: 5),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () =>
                                menuRead.removeCountOrder(context, index),
                            child: const Icon(Icons.remove_circle_outline,
                                color: Colors.red, size: 35.0),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.03,
                            child: AppTextStyle().textBold(
                                menuWatch.productAddModel!.responseObj!
                                    .orderList![index].qty
                                    .toString()
                                    .split(
                                        '.') //Why split ? because int.parse is Invalid radix-10 number. i don't know why
                                    .first,
                                size: 16),
                          ),
                          GestureDetector(
                            onTap: () => menuRead.addCountOrder(context, index),
                            child: const Icon(Icons.add_box_outlined,
                                color: Constants.primaryColor, size: 35.0),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.16,
                              child: AppTextStyle().textBold(
                                  menuWatch.productAddModel!.responseObj!
                                      .orderList![index].itemName!,
                                  size: 16)),
                          const Spacer(),
                          Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.06,
                              child: AppTextStyle().textBold(
                                  menuWatch.productAddModel!.responseObj!
                                      .orderList![index].retailPrice!
                                      .toString(),
                                  size: 16)),
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

Row orderTitle(MenuProvider menuWatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        child: AppTextStyle().textBold('DINE IN', size: 22),
      ),
      Container(
        child: menuWatch.productAddModel != null &&
                menuWatch.productAddModel!.responseCode!.isEmpty
            ? AppTextStyle().textBold(
                menuWatch.productAddModel!.responseObj!.dueAmount.toString(),
                size: 22)
            : AppTextStyle().textBold('0.00', size: 22),
      )
    ],
  );
}
