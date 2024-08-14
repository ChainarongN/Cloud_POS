import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HoldBillSearchPage extends StatefulWidget {
  const HoldBillSearchPage({super.key});

  @override
  State<HoldBillSearchPage> createState() => _HoldBillSearchPageState();
}

class _HoldBillSearchPageState extends State<HoldBillSearchPage> {
  @override
  Widget build(BuildContext context) {
    var homeRead = context.read<HomeProvider>();
    var homeWatch = context.watch<HomeProvider>();
    var menuRead = context.watch<MenuProvider>();
    return Scaffold(
      appBar: AppBar(title: AppTextStyle().textNormal('Hold bill search')),
      body: Padding(
        padding: EdgeInsets.all(Constants().screenWidth(context) * 0.01),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: homeWatch.holdBillSearchModel!.responseObj!.isEmpty
                  ? Center(
                      child: AppTextStyle().textNormal('No information'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount:
                          homeWatch.holdBillSearchModel!.responseObj!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            await homeRead.unHoldBill(
                                context,
                                homeWatch.holdBillSearchModel!
                                    .responseObj![index].orderId!);
                            if (homeWatch.apisState == ApiState.COMPLETED) {
                              menuRead
                                  .setTranData(
                                      tranModel:
                                          json.encode(homeWatch.openTranModel))
                                  .then((value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/menuPage', (route) => false);
                              });
                            }
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(
                                Constants().screenWidth(context) * 0.05,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              Constants().screenWidth(context) *
                                                  0.03),
                                      child: AppTextStyle().textNormal(
                                          homeWatch.holdBillSearchModel!
                                              .responseObj![index].saleModeName!,
                                          size: Constants().screenWidth(context) *
                                              Constants.normalSizeMB),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              Constants().screenWidth(context) *
                                                  0.03),
                                      child: AppTextStyle().textNormal(
                                          homeWatch.holdBillSearchModel!
                                              .responseObj![index].customerName!,
                                          size: Constants().screenWidth(context) *
                                              Constants.normalSizeMB),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              Constants().screenWidth(context) *
                                                  0.03),
                                      child: AppTextStyle().textNormal(
                                          homeWatch
                                              .holdBillSearchModel!
                                              .responseObj![index]
                                              .customerMobile!,
                                          size: Constants().screenWidth(context) *
                                              Constants.normalSizeMB),
                                    ),
                                    Container(
                                      child: AppTextStyle().textNormal(
                                          homeWatch.holdBillSearchModel!
                                              .responseObj![index].openTime!,
                                          size: Constants().screenWidth(context) *
                                              Constants.normalSizeMB),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
