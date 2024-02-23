import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

Center paymentTab(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(5),
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
                    height: Constants().screenheight(context) * 0.37,
                    child: Column(
                      children: <Widget>[
                        titlePaymentList(),
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
                    AppTextStyle().textBold('Payment - Credit Card.', size: 20)
                  ],
                ),
                SizedBox(height: Constants().screenheight(context) * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.11,
                      child:
                          AppTextStyle().textNormal('Total price : ', size: 16),
                    ),
                    SizedBox(width: Constants().screenWidth(context) * 0.008),
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.15,
                      height: Constants().screenheight(context) * 0.05,
                      child: TextField(
                        controller: menuWatch!.getDueAmountController,
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
                      child:
                          AppTextStyle().textNormal('Pay amount : ', size: 16),
                    ),
                    SizedBox(width: Constants().screenWidth(context) * 0.008),
                    Container(
                      width: Constants().screenWidth(context) * 0.15,
                      height: Constants().screenheight(context) * 0.05,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: menuWatch.getPayAmountCredit,
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
                    controller: menuWatch.getPaymentRemark,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Remark',
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
                              double.parse(menuWatch.getPayAmountCredit.text);
                          double dueAmount = double.parse(
                              menuWatch.getDueAmountController.text);
                          if (price > dueAmount) {
                            LoadingStyle().dialogError(context,
                                error:
                                    "Cannot do payment for amount more than due amount.",
                                isPopUntil: false);
                          } else {
                            await menuRead!
                                .managePayAmountList(context, 'add',
                                    payTypeId: payTypeId,
                                    payCode: payTypeCode,
                                    payName: payTypeName,
                                    payRemark: menuWatch.getPaymentRemark.text,
                                    price: menuWatch.getPayAmountCredit.text)
                                .then((value) => Navigator.maybePop(context));
                          }
                        },
                        child: AppTextStyle()
                            .textNormal('OK', color: Colors.green, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: Constants().screenWidth(context) * 0.1,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: AppTextStyle()
                            .textNormal('Cancel', color: Colors.red, size: 16),
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
    height: Constants().screenheight(context) * 0.33,
    child: SingleChildScrollView(
      child: menuWatch.payAmountList!.isEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 50),
              child: AppTextStyle().textNormal('There is no pay amount.'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                menuWatch.payAmountList!.length,
                (index) => Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) {
                          menuRead.managePayAmountList(context, 'remove',
                              indexForRemove: index);
                        },
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Delete',
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
                                menuWatch.payAmountList![index].payName!,
                                size: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: AppTextStyle().textNormal(
                                menuWatch.payAmountList![index].payRemark!,
                                size: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: AppTextStyle().textNormal(
                                menuWatch.payAmountList![index].price
                                    .toString(),
                                size: 16),
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

Row titlePaymentList() {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold('ประเภทรายจ่าย', size: 20),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold('รายละเอียด', size: 20),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          child: AppTextStyle().textBold('ราคา', size: 20),
        ),
      )
    ],
  );
}

Container totalPayAmount(
    BuildContext context, MenuProvider menuRead, MenuProvider menuWatch) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
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
                menuRead.managePayAmountList(context, 'clear');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete, size: 30, color: Colors.white),
                    const SizedBox(width: 5),
                    AppTextStyle()
                        .textBold('Clear', size: 20, color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: AppTextStyle().textBold('Total pay amount :  ', size: 16),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: menuWatch.getTotalPayController,
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
            style: const TextStyle(color: Constants.textColor, fontSize: 20),
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
    margin: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: menuWatch.getPayAmountController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              labelText: 'Enter your pay amount.',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
            style: const TextStyle(color: Constants.textColor, fontSize: 20),
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
                child: AppTextStyle()
                    .textBold('C', size: 25, color: Colors.white)),
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
                if (menuWatch.getPayAmountController.text.isNotEmpty) {
                  menuRead.managePayAmountList(context, 'add',
                      payCode: 'CS',
                      payTypeId: 1,
                      payName: 'Cash',
                      price: menuWatch.getPayAmountController.text);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  items: menuWatch.currencyitems
                      .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: AppTextStyle().textBold(item, size: 16)))
                      .toList(),
                  value: menuWatch.getValueCurrency,
                  onChanged: (value) {},
                  buttonStyleData: ButtonStyleData(
                    height: Constants().screenheight(context) * 0.07,
                    width: Constants().screenWidth(context) * 0.19,
                    padding: const EdgeInsets.only(left: 14, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: Constants().screenheight(context) * 0.07,
                    padding: const EdgeInsets.only(left: 14, right: 14),
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
                        margin: const EdgeInsets.only(bottom: 13),
                        child: ContainerStyle(
                          height: Constants().screenheight(context) * 0.1,
                          width: Constants().screenWidth(context) * 0.19,
                          primaryColor: Colors.amber.shade500,
                          secondaryColor: Colors.amber.shade600,
                          selected: false,
                          widget: AppTextStyle().textNormal(
                              menuWatch.payTypeInfoList![index].payTypeName!,
                              size: 18,
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
