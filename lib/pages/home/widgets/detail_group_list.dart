import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';

SizedBox detailGroupList(BuildContext context, HomeProvider homeWatch,
    HomeProvider homeRead, MenuProvider menuRead) {
  return SizedBox(
    width: Constants().screenWidth(context) * 0.65,
    child: SingleChildScrollView(
      child: Wrap(
        spacing: Constants().screenheight(context) * 0.01,
        runSpacing: Constants().screenheight(context) * 0.008,
        children: List.generate(
          homeWatch.saleModeDataList!.length,
          (index) => homeWatch.computerName!.saleModeList!.isEmpty
              ? saleModeContainer(homeWatch, index, context, homeRead, menuRead)
              : homeWatch.computerSaleMode.contains(
                      homeWatch.saleModeDataList![index].saleModeID.toString())
                  ? saleModeContainer(
                      homeWatch, index, context, homeRead, menuRead)
                  : const SizedBox.shrink(),
        ),
      ),
    ),
  );
}

Container saleModeContainer(HomeProvider homeWatch, int index,
    BuildContext context, HomeProvider homeRead, MenuProvider menuRead) {
  return Container(
    margin: const EdgeInsets.all(2),
    child: ContainerStyle2(
      onlyText: true,
      title: homeWatch.saleModeDataList![index].saleModeName!,
      icon: Icons.android,
      size: Constants().screenheight(context) * 0.023,
      radius: 35,
      width: Constants().screenWidth(context) * 0.2,
      height: Constants().screenheight(context) * 0.2,
      shadowColor: Colors.blue.shade400,
      gradient1: Colors.blue.shade200,
      gradient2: Colors.blue.shade300,
      gradient3: Colors.blue.shade500,
      gradient4: Colors.blue.shade500,
      onPressed: () async {
        DialogStyle().dialogLoadding(context);
        await homeRead.openTransaction(context, index: index).then((value) {
          if (homeWatch.apisState == ApiState.COMPLETED) {
            homeRead.setCountText('1');
            homeRead.setSex('');
            homeRead.setNationality('');
            Navigator.maybePop(context);
            menuRead
                .setTranData(tranModel: json.encode(homeWatch.openTranModel))
                .then((value) {
              Navigator.pushNamed(context, '/menuPage');
            });
          }
        });
      },
    ),
  );
}
