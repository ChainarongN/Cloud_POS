import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

SingleChildScrollView printerSetting(BuildContext context,
    ConfigProvider configRead, ConfigProvider configWatch) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        receiptPrinter(context, configRead, configWatch),
        printerModel(context, configRead, configWatch),
        connectionType(context, configRead, configWatch),
        printerAddress(context),
        testPrintBtn(context),
        btnSave(context),
      ],
    ),
  );
}

Container btnSave(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height * 0.09,
    width: MediaQuery.of(context).size.width * 0.66,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 113, 134, 255),
          Color.fromARGB(255, 157, 198, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(255, 157, 198, 255),
            blurRadius: 8,
            offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              )),
          AppTextStyle()
              .textNormal('Save Config', size: 20, color: Colors.white),
        ],
      ),
    ),
  );
}

Container testPrintBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height * 0.09,
    width: MediaQuery.of(context).size.width * 0.32,
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 138, 196, 255),
          Color.fromARGB(255, 182, 212, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(255, 182, 212, 255),
            blurRadius: 8,
            offset: Offset(0, 6)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(
                Icons.print,
                size: 40,
                color: Colors.white,
              )),
          AppTextStyle().textNormal('Test Print to Receipt Printer',
              size: 20, color: Colors.white),
        ],
      ),
    ),
  );
}

SizedBox printerAddress(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.66,
    height: MediaQuery.of(context).size.height * 0.13,
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('IP Address Printer : ', size: 18),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.44,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100.withOpacity(0.1),
                  labelText: "Printer IP Address",
                  border: myinputborder(),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 30, right: 25),
                    child: Icon(
                      Icons.wifi_password,
                      size: 35,
                    ),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.cancel),
                  )),
              style: const TextStyle(color: Constants.textColor, fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}

SizedBox connectionType(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.5,
    height: MediaQuery.of(context).size.height * 0.13,
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('Connection Type : ', size: 18),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.17,
            child: dropdownButton(
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getConnectList,
                value: configWatch.getConnectionValue,
                onChanged: (value) {
                  configRead.setConnectionValue(value!);
                  Constants().printWarning(configWatch.getConnectionValue);
                }),
          ),
        ],
      ),
    ),
  );
}

Container printerModel(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    width: MediaQuery.of(context).size.width * 0.5,
    height: MediaQuery.of(context).size.height * 0.13,
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal('Printer Model : ', size: 18),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.17,
            child: dropdownButton(
                configRead: configRead,
                configWatch: configWatch,
                itemMap: configWatch.getPrinterList,
                value: configWatch.getPrintValue,
                onChanged: (value) {
                  configRead.setPrinterValue(value!);
                  Constants().printWarning(configWatch.getPrintValue);
                }),
          ),
        ],
      ),
    ),
  );
}

DropdownButtonFormField2<String> dropdownButton(
    {ConfigProvider? configWatch,
    ConfigProvider? configRead,
    List<String>? itemMap,
    String? value,
    Function(String?)? onChanged}) {
  return DropdownButtonFormField2<String>(
    isExpanded: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    value: value,
    items: itemMap!
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ))
        .toList(),
    onChanged: onChanged,
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 8),
    ),
    iconStyleData: const IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}

Container receiptPrinter(BuildContext context, ConfigProvider configRead,
    ConfigProvider configWatch) {
  return Container(
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height * 0.09,
    width: MediaQuery.of(context).size.width * 0.66,
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 113, 134, 255),
          Color.fromARGB(255, 157, 198, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 157, 198, 255),
          blurRadius: 8,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: <Widget>[
          AppTextStyle().textNormal(
            'Receipt Printer',
            size: 20,
            color: Colors.white,
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.065,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Constants.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.print,
                  color: configWatch.getprinterSwitch
                      ? Constants.primaryColor
                      : Colors.grey.shade500,
                  size: 40,
                ),
                Switch(
                  value: configWatch.getprinterSwitch,
                  activeColor: Colors.blue.shade600,
                  onChanged: (bool value) {
                    configRead.setPrinterSwitch(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.black45),
  );
}
