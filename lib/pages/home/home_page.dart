import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/home/widgets/add_customer.dart';
import 'package:cloud_pos/pages/home/widgets/detail_group_list.dart';
import 'package:cloud_pos/pages/home/widgets/drawer.dart';
import 'package:cloud_pos/pages/home/widgets/group_list.dart';
import 'package:cloud_pos/pages/home/widgets/nationality.dart';
import 'package:cloud_pos/pages/home/widgets/sex.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    var homeRead = context.read<HomeProvider>();
    var homeWatch = context.watch<HomeProvider>();
    var menuRead = context.read<MenuProvider>();
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        title: const Text('Clound Pos'),
      ),
      drawer: drawer(context),
      body: homeWatch.apisState == ApiState.LOADING ||
              homeWatch.saleModeDataList!.isEmpty
          ? const LoaddingData()
          : Padding(
              padding:
                  EdgeInsets.all(Constants().screenheight(context) * 0.025),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: Constants().screenWidth(context) * 0.30,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              height:
                                  Constants().screenheight(context) * 0.015),
                          addCustomer(context, homeWatch, homeRead),
                          SizedBox(
                              height: Constants().screenheight(context) * 0.03),
                          AppTextStyle().textBold(LocaleKeys.nationality.tr()),
                          SizedBox(
                              height:
                                  Constants().screenheight(context) * 0.024),
                          nationality(homeWatch, homeRead, context),
                          SizedBox(
                              height: Constants().screenheight(context) * 0.02),
                          AppTextStyle().textBold(LocaleKeys.sex.tr()),
                          SizedBox(
                              height: Constants().screenheight(context) * 0.02),
                          sex(homeWatch, homeRead, context),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3, right: 3),
                    child: const VerticalDivider(thickness: 1),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        groupList(context, homeWatch, homeRead),
                        Container(
                          width: Constants().screenWidth(context) * 0.5,
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: const Divider(thickness: 1.5),
                        ),
                        detailGroupList(context, homeWatch, homeRead, menuRead)
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
