import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> reasonDialogTablet(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Consumer<MenuProvider>(
      builder: (context, dataProvider, child) => AlertDialog(
        title: AppTextStyle().textNormal(LocaleKeys.close_tran_title.tr(),
            size: Constants().screenheight(context) * 0.03),
        content: SizedBox(
          width: Constants().screenWidth(context),
          height: Constants().screenheight(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // groupMenu(context, dataProvider),
              // const VerticalDivider(thickness: 1),
              detailReason(context, dataProvider),
              resultData(context, dataProvider)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenheight(context) * 0.03),
            onPressed: () async {
              if (dataProvider.reasonTextController.text.isNotEmpty ||
                  dataProvider.reasonController.text.isNotEmpty) {
                LoadingStyle().dialogLoadding(context);
                await dataProvider.cancelTransaction(context);
              } else {
                dataProvider.setExceptionText(
                    LocaleKeys.please_select_or_input_your_reason.tr());
              }
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: Constants().screenheight(context) * 0.03,
                color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> openConfCancel(BuildContext context, MenuProvider menuRead) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: Constants().screenheight(context) * 0.24,
          width: Constants().screenWidth(context) * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Username',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 15),
                      child: Icon(Icons.people),
                    ),
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.024),
                  onChanged: (value) {
                    menuRead.usernameCancel = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    labelText: 'Password',
                    border: Constants().myinputborder(), //normal border
                    enabledBorder: Constants().myinputborder(), //enabled border
                    focusedBorder: Constants().myfocusborder(), //focused border
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 15),
                      child: Icon(Icons.lock),
                    ),
                  ),
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: Constants().screenheight(context) * 0.024),
                  onChanged: (value) {
                    menuRead.passwordCancel = value;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(), size: 18),
            onPressed: () async {
              LoadingStyle().dialogLoadding(context);
              await menuRead.authInfo(context);
              Navigator.maybePop(context).then((value) {
                menuRead.clearReasonText();
                menuRead.setExceptionText('');
                reasonDialogTablet(context);
              });
            },
          ),
          TextButton(
            child: AppTextStyle().textNormal(LocaleKeys.cancel.tr(),
                size: 18, color: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

SingleChildScrollView resultData(
    BuildContext context, MenuProvider dataProvider) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: Constants().screenWidth(context) * 0.28,
          height: Constants().screenheight(context) * 0.24,
          child: Card(
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dataProvider.reasonController,
                readOnly: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration.collapsed(hintText: ""),
              ),
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
          child: GestureDetector(
            onTap: () => dataProvider.clearReasonText(),
            child: ContainerStyle(
              height: Constants().screenheight(context) * 0.08,
              width: Constants().screenWidth(context) * 0.115,
              primaryColor: Constants.primaryColor,
              secondaryColor: Colors.blue.shade800,
              selected: false,
              widget: AppTextStyle().textNormal(LocaleKeys.clear.tr(),
                  size: Constants().screenheight(context) * 0.02,
                  color: Colors.white),
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: Constants().screenheight(context) * 0.01),
          width: Constants().screenWidth(context) * 0.27,
          child: TextField(
            controller: dataProvider.reasonTextController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              labelText: LocaleKeys.input_you_other_reason.tr(),
              border: Constants().myColorborder(Constants.textColor),
              enabledBorder: Constants().myColorborder(Constants.textColor),
              focusedBorder: Constants().myColorborder(Constants.textColor),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                    left: Constants().screenheight(context) * 0.025,
                    right: Constants().screenheight(context) * 0.015),
                child: const Icon(Icons.border_color_outlined),
              ),
            ),
            style: TextStyle(
                color: Constants.textColor,
                fontSize: Constants().screenheight(context) * 0.025),
            maxLines: null,
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: Constants().screenheight(context) * 0.015),
          child: AppTextStyle()
              .textNormal(dataProvider.getExceptionText, color: Colors.red),
        ),
      ],
    ),
  );
}

SizedBox detailReason(BuildContext context, MenuProvider dataProvider) {
  return SizedBox(
    height: Constants().screenheight(context),
    width: Constants().screenWidth(context) * 0.44,
    child: dataProvider.authInfoModel == null ||
            dataProvider.authInfoModel!.responseCode!.isNotEmpty
        ? Center(
            child: AppTextStyle()
                .textNormal(LocaleKeys.something_wrong_please_try_again.tr()),
          )
        : SingleChildScrollView(
            child: Wrap(
              runSpacing: 10,
              children: List.generate(
                dataProvider.authInfoModel!.responseObj2!.length,
                (index) => GestureDetector(
                  onTap: () => dataProvider.addReasonText(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ContainerStyle(
                        height: Constants().screenheight(context) * 0.1,
                        width: Constants().screenWidth(context) * 0.135,
                        primaryColor: const Color.fromARGB(255, 255, 104, 190),
                        secondaryColor:
                            const Color.fromARGB(255, 254, 144, 190),
                        selected: false,
                        widget: AppTextStyle().textNormal(
                            dataProvider
                                .authInfoModel!.responseObj2![index].text!,
                            size: Constants().screenheight(context) * 0.02,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
  );
}

SizedBox groupMenu(BuildContext context, MenuProvider dataProvider) {
  return SizedBox(
    height: Constants().screenheight(context),
    child: SingleChildScrollView(
        child: Column(
      children: List.generate(
        dataProvider.reasonGroupList!.length,
        (index) => GestureDetector(
          onTap: () {
            dataProvider.setReason(context, index);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                bottom: Constants().screenheight(context) * 0.015),
            child: ContainerStyle(
              height: Constants().screenheight(context) * 0.1,
              width: Constants().screenWidth(context) * 0.135,
              primaryColor: const Color(0xffDA0C81),
              secondaryColor: const Color(0xffE95793),
              selected: dataProvider.getvalueReasonGroupSelect ==
                      dataProvider.reasonGroupList![index].name
                  ? true
                  : false,
              widget: AppTextStyle().textNormal(
                  dataProvider.reasonGroupList![index].name!,
                  size: Constants().screenheight(context) * 0.024,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    )),
  );
}
