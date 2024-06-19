import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Center paymentTabTablet(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.004),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: Constants().screenheight(context) * 0.35,
                    child: Column(
                      children: <Widget>[
                        titlePaymentList(context),
                        paymentList(context, menuWatch, menuRead)
                      ],
                    ),
                  ),
                  totalPayAmount(context, menuRead, menuWatch),
                  inputTextField(context, menuWatch, menuRead),
                  bangNotes(context, menuWatch)
                ],
              ),
            ),
          ),
          listPaymentType(context, menuWatch, menuRead),
        ],
      ),
    ),
  );
}

Future dialogPayment(BuildContext context,
    {int? payTypeId,
    String? payTypeName,
    String? payTypeCode,
    MenuProvider? menuRead,
    MenuProvider? menuWatch}) async {
  menuRead!.clearPaymentField();
  switch (payTypeId) {
    case 2:
      dialogCredit(context,
          payTypeId: payTypeId,
          payTypeName: payTypeName,
          payTypeCode: payTypeCode,
          menuRead: menuRead,
          menuWatch: menuWatch);
      break;
  }
}

Future<void> dialogCredit(BuildContext context,
    {int? payTypeId,
    String? payTypeName,
    String? payTypeCode,
    MenuProvider? menuRead,
    MenuProvider? menuWatch}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      menuWatch!.dueAmountController.text =
          menuWatch.transactionModel!.responseObj!.dueAmount.toString();
      return Dialog(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.android, size: 35),
                    SizedBox(width: Constants().screenWidth(context) * 0.02),
                    AppTextStyle().textBold(
                        '${LocaleKeys.payment.tr()} - ${LocaleKeys.credit_card.tr()}.',
                        size: 20)
                  ],
                ),
                SizedBox(height: Constants().screenheight(context) * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.11,
                      child: AppTextStyle().textNormal(
                          '${LocaleKeys.total_price.tr()} : ',
                          size: 16),
                    ),
                    SizedBox(width: Constants().screenWidth(context) * 0.008),
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.15,
                      height: Constants().screenheight(context) * 0.05,
                      child: TextField(
                        controller: menuWatch.dueAmountController,
                        readOnly: true,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(8),
                          suffixText: ' THB.',
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.2),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                        style: const TextStyle(
                            color: Constants.textColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constants().screenheight(context) * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.11,
                      child: AppTextStyle().textNormal(
                          '${LocaleKeys.pay_amount.tr()} : ',
                          size: 16),
                    ),
                    SizedBox(width: Constants().screenWidth(context) * 0.008),
                    Container(
                      width: Constants().screenWidth(context) * 0.15,
                      height: Constants().screenheight(context) * 0.05,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: menuWatch.payAmountCredit,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        ],
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          suffixText: ' THB.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                        style: const TextStyle(
                            color: Constants.textColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constants().screenheight(context) * 0.025),
                SizedBox(
                  width: Constants().screenWidth(context) * 0.26,
                  height: Constants().screenheight(context) * 0.1,
                  child: TextField(
                    controller: menuWatch.paymentRemark,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: LocaleKeys.remark.tr(),
                    ),
                  ),
                ),
                SizedBox(height: Constants().screenheight(context) * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.1,
                      child: ElevatedButton(
                        onPressed: () async {
                          double price =
                              double.parse(menuWatch.payAmountCredit.text);
                          if (price >
                              menuWatch
                                  .transactionModel!.responseObj!.dueAmount!) {
                            LoadingStyle().dialogError(context,
                                error: LocaleKeys
                                    .cannot_do_payment_for_amount_more_than_due_amount
                                    .tr(),
                                isPopUntil: false);
                          } else {
                            await menuRead!
                                .paymentMulti(
                                    context: context,
                                    payTypeId: payTypeId,
                                    payCode: payTypeCode,
                                    payName: payTypeName,
                                    payRemark: menuWatch.paymentRemark.text,
                                    payAmount: menuWatch.payAmountCredit.text)
                                .then((value) => Navigator.maybePop(context));
                          }
                        },
                        child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                            color: Colors.green, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.1,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                            color: Colors.red, size: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Container bangNotes(BuildContext context, MenuProvider menuWatch) {
  return Container(
    width: Constants().screenWidth(context),
    height: Constants().screenheight(context) * 0.225,
    margin: const EdgeInsets.only(top: 8),
    child: Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 5,
      spacing: 25,
      children: <Widget>[
        GestureDetector(
          onTap: () => menuWatch.setPayAmountField(20),
          child: SizedBox(
            width: Constants().screenWidth(context) * 0.12,
            child: Image.asset(Constants.twentyImg),
          ),
        ),
        GestureDetector(
          onTap: () => menuWatch.setPayAmountField(50),
          child: SizedBox(
            width: Constants().screenWidth(context) * 0.12,
            child: Image.asset(Constants.fiftyImg),
          ),
        ),
        GestureDetector(
          onTap: () => menuWatch.setPayAmountField(100),
          child: SizedBox(
            width: Constants().screenWidth(context) * 0.12,
            child: Image.asset(Constants.one_hundredImg),
          ),
        ),
        GestureDetector(
          onTap: () => menuWatch.setPayAmountField(500),
          child: SizedBox(
            width: Constants().screenWidth(context) * 0.12,
            child: Image.asset(Constants.five_hundredImg),
          ),
        ),
        GestureDetector(
          onTap: () => menuWatch.setPayAmountField(1000),
          child: SizedBox(
            width: Constants().screenWidth(context) * 0.128,
            child: Image.asset(Constants.thousandImg),
          ),
        ),
      ],
    ),
  );
}

SizedBox paymentList(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return SizedBox(
    height: Constants().screenheight(context) * 0.3,
    child: SingleChildScrollView(
      child: menuWatch.transactionModel!.responseObj!.paymentList!.isEmpty
          ? Container(
              margin: EdgeInsets.only(
                  top: Constants().screenheight(context) * 0.07),
              child: AppTextStyle()
                  .textNormal('${LocaleKeys.there_is_no_pay_amount.tr()}.'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                menuWatch.transactionModel!.responseObj!.paymentList!.length,
                (index) => Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        flex: 1,
                        onPressed: (contextSlidable) {
                          LoadingStyle().dialogLoadding(context);
                          menuRead
                              .paymentCancel(
                                  context,
                                  menuWatch.transactionModel!.responseObj!
                                      .paymentList![index].payDetailID
                                      .toString())
                              .then((value) {
                            if (menuWatch.apiState == ApiState.COMPLETED) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: LocaleKeys.delete.tr(),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: Constants().screenheight(context) * 0.07,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: AppTextStyle().textNormal(
                                menuWatch.transactionModel!.responseObj!
                                    .paymentList![index].payTypeName!,
                                size:
                                    Constants().screenheight(context) * 0.025),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: AppTextStyle().textNormal(
                                menuWatch.transactionModel!.responseObj!
                                    .paymentList![index].remark!,
                                size:
                                    Constants().screenheight(context) * 0.025),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: AppTextStyle().textNormal(
                                menuWatch.transactionModel!.responseObj!
                                    .paymentList![index].payAmount
                                    .toString(),
                                size:
                                    Constants().screenheight(context) * 0.025),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    ),
  );
}

Row titlePaymentList(BuildContext context) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold(LocaleKeys.payment_type.tr(),
              size: Constants().screenheight(context) * 0.03),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold(LocaleKeys.detail.tr(),
              size: Constants().screenheight(context) * 0.03),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold(LocaleKeys.price.tr(),
              size: Constants().screenheight(context) * 0.03),
        ),
      )
    ],
  );
}

Container totalPayAmount(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Container(
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.01),
    height: Constants().screenheight(context) * 0.08,
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: Constants().screenheight(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.shade100,
                side: const BorderSide(width: 2, color: Colors.white),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                menuRead.clearPaymentList(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete,
                      size: Constants().screenheight(context) * 0.045,
                      color: Colors.white),
                  SizedBox(width: Constants().screenheight(context) * 0.015),
                  AppTextStyle().textBold(LocaleKeys.clear.tr(),
                      size: Constants().screenheight(context) * 0.03,
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: AppTextStyle().textBold('Due Amount :  ',
                size: Constants().screenheight(context) * 0.023),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: menuWatch.dueAmountController,
            readOnly: true,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
            style: TextStyle(
                color: Constants.textColor,
                fontSize: Constants().screenheight(context) * 0.03),
          ),
        ),
      ],
    ),
  );
}

Container inputTextField(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Container(
    height: Constants().screenheight(context) * 0.08,
    margin: EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: menuWatch.payAmountController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              labelText: '${LocaleKeys.enter_your_pay_amount.tr()}.',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
            style: TextStyle(
                color: Constants.textColor,
                fontSize: Constants().screenheight(context) * 0.025),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: Constants().screenheight(context),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  side: const BorderSide(width: 2, color: Colors.white),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => menuRead.clearPayAmount(),
                child: AppTextStyle().textBold('C',
                    size: Constants().screenheight(context) * 0.034,
                    color: Colors.white)),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: Constants().screenheight(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade400,
                side: const BorderSide(width: 2, color: Colors.white),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (menuWatch.payAmountController.text.isNotEmpty) {
                  menuRead.paymentMulti(
                      context: context,
                      payCode: 'CS',
                      payTypeId: 1,
                      payName: 'Cash',
                      payAmount: menuWatch.payAmountController.text);
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.all(Constants().screenheight(context) * 0.01),
                child: Image.asset('assets/enter1.png', color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Expanded listPaymentType(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Expanded(
    flex: 1,
    child: SizedBox(
      height: Constants().screenheight(context),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  bottom: Constants().screenheight(context) * 0.015,
                  top: Constants().screenheight(context) * 0.008),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  items: menuWatch.currencyInfo!
                      .map((e) => DropdownMenuItem<String>(
                            value: e.currencyCode,
                            child: AppTextStyle()
                                .textBold(e.currencyCode!, size: 16),
                          ))
                      .toList(),
                  value: menuWatch.getValueCurrency,
                  onChanged: (value) {},
                  buttonStyleData: ButtonStyleData(
                    height: Constants().screenheight(context) * 0.07,
                    width: Constants().screenWidth(context) * 0.19,
                    padding: EdgeInsets.only(
                        left: Constants().screenheight(context) * 0.02,
                        right: Constants().screenheight(context) * 0.025),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: Constants().screenheight(context) * 0.02,
                    iconEnabledColor: Colors.black,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: Constants().screenheight(context) * 0.07,
                    padding: EdgeInsets.only(
                        left: Constants().screenheight(context) * 0.02,
                        right: Constants().screenheight(context) * 0.025),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Constants().screenheight(context) * 0.69,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    menuWatch.payTypeInfoList!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        dialogPayment(context,
                            payTypeId:
                                menuWatch.payTypeInfoList![index].payTypeID,
                            payTypeName:
                                menuWatch.payTypeInfoList![index].payTypeName,
                            payTypeCode:
                                menuWatch.payTypeInfoList![index].payTypeCode,
                            menuRead: menuRead,
                            menuWatch: menuWatch);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: Constants().screenheight(context) * 0.018),
                        child: ContainerStyle(
                          height: Constants().screenheight(context) * 0.1,
                          width: Constants().screenWidth(context) * 0.19,
                          primaryColor: Colors.amber.shade500,
                          secondaryColor: Colors.amber.shade600,
                          selected: false,
                          widget: AppTextStyle().textNormal(
                              menuWatch.payTypeInfoList![index].payTypeName!,
                              size: Constants().screenheight(context) * 0.025,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
