import 'package:cloud_pos/pages/home/widgets/add_customer.dart';
import 'package:cloud_pos/pages/home/widgets/detail_group_list.dart';
import 'package:cloud_pos/pages/home/widgets/drawer.dart';
import 'package:cloud_pos/pages/home/widgets/group_list.dart';
import 'package:cloud_pos/pages/home/widgets/nationality.dart';
import 'package:cloud_pos/pages/home/widgets/sex.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    context.read<HomeProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    var homeRead = context.read<HomeProvider>();
    var homeWatch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clound Pos'),
      ),
      drawer: drawer(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // selectDropdown(context, homeWatch, homeRead, 'Category'),
                  // const SizedBox(height: 10),
                  // selectDropdown(context, homeWatch, homeRead, 'Service'),
                  const SizedBox(height: 10),
                  addCustomer(homeWatch, homeRead),
                  const SizedBox(height: 30),
                  AppTextStyle().textBold('สัญชาติ'),
                  const SizedBox(height: 15),
                  nationality(homeWatch, homeRead, context),
                  const SizedBox(height: 10),
                  AppTextStyle().textBold('เพศ'),
                  const SizedBox(height: 15),
                  sex(homeWatch, homeRead, context),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 3),
              child: const VerticalDivider(thickness: 1),
            ),
            Column(
              children: <Widget>[
                groupList(context, homeWatch, homeRead),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: const Divider(thickness: 1.5),
                ),
                detailGroupList(context, homeWatch, homeRead)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
