import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/widgets/appbar_action.dart';
import 'package:cloud_pos/pages/menu/widgets/manage_menu.dart';
import 'package:cloud_pos/pages/menu/widgets/tab_menu_title.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/fav_one_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/menu_tab.dart';
import 'package:cloud_pos/pages/menu/widgets/tabview/search_tab.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/custom_error_widget.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<MenuProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    var menuRead = context.read<MenuProvider>();
    var menuWatch = context.watch<MenuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('Menu'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              menuRead.clearReasonText();
              reasonDialog(context);
            }),
        actions: <Widget>[
          employee(context),
          member(context),
          clonebin(context),
        ],
      ),
      body: menuWatch.apiState == ApiState.LOADING
          ? const LoaddingData()
          : menuWatch.apiState == ApiState.ERROR
              ? CustomErrorWidget(errorMessage: menuWatch.getExceptionText)
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants.primaryColor),
                      color: Constants.secondaryColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // listItem(menuWatch, context),
                        manageMenu(context, menuWatch, menuRead),
                        tabViewAll(context, menuWatch, menuRead),
                      ],
                    ),
                  ),
                ),
    );
  }

  Future<void> reasonDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => Consumer<MenuProvider>(
        builder: (context, dataProvider, child) => AlertDialog(
          title: AppTextStyle().textNormal(
              'Close Transaction : Please select your reason.',
              size: 20),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Column(
                    children: List.generate(
                      dataProvider.reasonGroupList!.length,
                      (index) => GestureDetector(
                        onTap: () {
                          dataProvider.setReason(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ContainerStyle(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.135,
                            primaryColor: const Color(0xffDA0C81),
                            secondaryColor: const Color(0xffE95793),
                            selected: dataProvider.getvalueReasonGroupSelect ==
                                    dataProvider.reasonGroupList![index].name
                                ? true
                                : false,
                            widget: AppTextStyle().textNormal(
                                dataProvider.reasonGroupList![index].name!,
                                size: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
                const VerticalDivider(thickness: 1),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: SingleChildScrollView(
                    child: dataProvider.apiState == ApiState.LOADING
                        ? const LoaddingData()
                        : dataProvider.apiState == ApiState.ERROR
                            ? CustomErrorWidget(
                                errorMessage: dataProvider.getExceptionText)
                            : Wrap(
                                runSpacing: 10,
                                children: List.generate(
                                  dataProvider.reasonModel!.responseObj!.length,
                                  (index) => GestureDetector(
                                    onTap: () =>
                                        dataProvider.addReasonText(index),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ContainerStyle(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.135,
                                          primaryColor: const Color.fromARGB(
                                              255, 255, 104, 190),
                                          secondaryColor: const Color.fromARGB(
                                              255, 254, 144, 190),
                                          selected: false,
                                          widget: AppTextStyle().textNormal(
                                              dataProvider.reasonModel!
                                                  .responseObj![index].text!,
                                              size: 16,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: dataProvider.getReasonController,
                            readOnly: true,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Select your reason"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => dataProvider.clearReasonText(),
                        child: ContainerStyle(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.115,
                          primaryColor: Constants.primaryColor,
                          secondaryColor: Colors.blue.shade800,
                          selected: false,
                          widget: AppTextStyle().textNormal('Clear',
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: AppTextStyle().textNormal('OK', size: 20),
              onPressed: () async {
                Constants().dialogBuilder(context);
                await dataProvider.cancelTransaction().then((value) {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/homePage'));
                });
              },
            ),
            TextButton(
              child: AppTextStyle()
                  .textNormal('Cancel', size: 20, color: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded tabViewAll(
      BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
    return Expanded(
      child: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            tabMenuTitle(),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  menuTab(context, menuWatch, menuRead),
                  favoriteTab1(context, menuWatch, menuRead),
                  Center(
                    child: Text("Fav#2"),
                  ),
                  searchTab(context, menuWatch, menuRead),
                  Center(
                    child: Text("ส่วนลด"),
                  ),
                  Center(
                    child: Text("จ่ายเงิน"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
