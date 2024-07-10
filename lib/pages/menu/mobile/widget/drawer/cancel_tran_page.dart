import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelTranPage extends StatefulWidget {
  const CancelTranPage({super.key});

  @override
  State<CancelTranPage> createState() => _CancelTranPageState();
}

class _CancelTranPageState extends State<CancelTranPage> {
  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();
    return Scaffold(
      appBar: AppBar(title: AppTextStyle().textNormal('Close Transaction')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(menuWatch, context, menuRead),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              menuWatch.authInfoModel == null ||
                      menuWatch.authInfoModel!.responseCode!.isNotEmpty
                  ? Center(
                      child: AppTextStyle().textNormal(
                          LocaleKeys.something_wrong_please_try_again.tr()),
                    )
                  : resultReason(context, menuWatch, menuRead),
              resultData(context, menuRead),
            ],
          ),
        ),
      ),
    );
  }

  Container floatingActionButton(
      MenuProvider menuWatch, BuildContext context, MenuProvider menuRead) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 223, 35, 35)),
        onPressed: () async {
          if (menuWatch.reasonTextController.text.isNotEmpty ||
              menuWatch.reasonController.text.isNotEmpty) {
            LoadingStyle().dialogLoadding(context);
            if (menuWatch.indexSaleMode == null) {
              await menuRead.cancelTransaction(context);
            } else {
              await menuRead.cancelTransaction(context,
                  indexSaleMode: menuWatch.indexSaleMode);
            }
          } else {
            menuRead.setExceptionText(
                LocaleKeys.please_select_or_input_your_reason.tr());
          }
        },
        child: Center(
          child: AppTextStyle().textBold('Close Transaction',
              size: Constants().screenWidth(context) * Constants.boldSize,
              color: Colors.white),
        ),
      ),
    );
  }

  SingleChildScrollView resultReason(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            top: Constants().screenheight(context) * 0.01,
            bottom: Constants().screenheight(context) * 0.02),
        child: Wrap(
          runSpacing: 10,
          children: List.generate(
            menuWatch.authInfoModel!.responseObj2!.length,
            (index) => GestureDetector(
              onTap: () => menuRead.addReasonText(index),
              child: Container(
                margin: EdgeInsets.only(
                    right: Constants().screenWidth(context) * 0.015),
                child: ContainerStyle(
                    height: Constants().screenheight(context) * 0.1,
                    width: Constants().screenWidth(context) * 0.3,
                    primaryColor: const Color.fromARGB(255, 255, 104, 190),
                    secondaryColor: const Color.fromARGB(255, 254, 144, 190),
                    selected: false,
                    widget: AppTextStyle().textNormal(
                        menuWatch.authInfoModel!.responseObj2![index].text!,
                        size: Constants().screenheight(context) * 0.02,
                        color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> openConfCancel(BuildContext context, MenuProvider menuRead,
    {int? indexSaleMode}) {
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
            child: AppTextStyle().textNormal(LocaleKeys.ok.tr(),
                size: Constants().screenWidth(context) * Constants.normalSize),
            onPressed: () async {
              LoadingStyle().dialogLoadding(context);
              if (indexSaleMode == null) {
                menuRead.indexSaleMode = null;
                await menuRead.authInfo(context).then((value) {
                  Navigator.maybePop(context).then((value) {
                    menuRead.clearReasonText();
                    menuRead.setExceptionText('');
                    Navigator.pushNamed(context, '/cancelTranPage');
                  });
                });
              } else {
                menuRead.indexSaleMode = indexSaleMode;
                await menuRead.authInfo(context).then((value) {
                  Navigator.maybePop(context).then((value) {
                    menuRead.clearReasonText();
                    menuRead.setExceptionText('');
                    Navigator.pushNamed(context, '/cancelTranPage');
                  });
                });
              }
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
      );
    },
  );
}

SingleChildScrollView resultData(
    BuildContext context, MenuProvider dataProvider) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Constants().screenWidth(context),
          height: Constants().screenheight(context) * 0.14,
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
              EdgeInsets.only(top: Constants().screenheight(context) * 0.005),
          child: GestureDetector(
            onTap: () => dataProvider.clearReasonText(),
            child: ContainerStyle(
              height: Constants().screenheight(context) * 0.055,
              width: Constants().screenWidth(context) * 0.25,
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
          width: Constants().screenWidth(context),
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
