import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
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
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: Column(
                      children: <Widget>[
                        titlePaymentList(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.33,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                20,
                                (index) => Slidable(
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) {},
                                        backgroundColor: Colors.redAccent,
                                        foregroundColor: Colors.white,
                                        icon: Icons.save,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: AppTextStyle().textNormal(
                                                'ประเภทรายจ่าย test',
                                                size: 16),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: AppTextStyle().textNormal(
                                                'รายละเอียด test',
                                                size: 16),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: AppTextStyle().textNormal(
                                                '2520.00',
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
                        )
                      ],
                    ),
                  ),
                  totalPayAmount(context),
                  inputTextField(context),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.15,
                  //   color: Colors.blueGrey.shade100,
                  // ),
                ],
              ),
            ),
          ),
          listPaymentType(context, menuWatch),
        ],
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

Container totalPayAmount(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    height: MediaQuery.of(context).size.height * 0.08,
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.shade100,
                side: const BorderSide(width: 2, color: Colors.white),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete, size: 40, color: Colors.white),
                    const SizedBox(width: 5),
                    AppTextStyle()
                        .textBold('Clear', size: 25, color: Colors.white)
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
            readOnly: true,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
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

Container inputTextField(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.08,
    margin: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
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
            height: MediaQuery.of(context).size.height,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  side: const BorderSide(width: 2, color: Colors.white),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: AppTextStyle()
                    .textBold('C', size: 25, color: Colors.white)),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade400,
                side: const BorderSide(width: 2, color: Colors.white),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
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

Expanded listPaymentType(BuildContext context, MenuProvider menuWatch) {
  return Expanded(
    flex: 1,
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
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
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.19,
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
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.69,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    10,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ContainerStyle(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.19,
                        primaryColor: Colors.amber.shade300,
                        secondaryColor: Colors.amber.shade500,
                        selected: false,
                        widget: AppTextStyle().textNormal('test data',
                            size: 18, color: Colors.white),
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
