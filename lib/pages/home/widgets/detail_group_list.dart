import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';

SizedBox detailGroupList(BuildContext context, HomeProvider homeWatch,
    HomeProvider homeRead, MenuProvider menuRead) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.65,
    height: MediaQuery.of(context).size.height * 0.65,
    child: SingleChildScrollView(
      child: Wrap(
        spacing: 3,
        runSpacing: 5,
        children: List.generate(
          homeWatch.saleModeDataList!.length,
          (index) => Container(
            margin: const EdgeInsets.all(2),
            child: ContainerStyle2(
              onlyText: true, 
              title: homeWatch.saleModeDataList![index].saleModeName!,
              icon: Icons.android,
              size: 16,
              radius: 35,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              shadowColor: Colors.blue.shade400,
              gradient1: Colors.blue.shade200,
              gradient2: Colors.blue.shade300,
              gradient3: Colors.blue.shade500,
              gradient4: Colors.blue.shade500,
              onPressed: () async {
                LoadingStyle().dialogLoadding(context);
                await homeRead.openTransaction(context, index).then((value) {
                  if (homeWatch.apisState == ApiState.COMPLETED) {
                    Navigator.maybePop(context);
                    menuRead
                        .setOrderId(homeWatch
                            .openTranModel!.responseObj!.tranData!.orderID!)
                        .then((value) {
                      Navigator.pushNamed(context, '/menuPage');
                    });
                  } else {
                    Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      LoadingStyle()
                          .dialogError(context, homeWatch.getErrorText);
                    });
                  }
                });
              },
            ),
          ),
        ),
      ),
    ),
  );
}
