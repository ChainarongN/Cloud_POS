import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/custom_error_widget.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
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
          (index) => GestureDetector(
            onTap: () async {
              _dialogBuilder(context);
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
                  Navigator.maybePop(context);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    errorDialog(context, homeWatch);
                  });
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(2),
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
                      color: Color.fromARGB(255, 157, 198, 255),
                      blurRadius: 8,
                      offset: Offset(0, 6)),
                ],
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Icon(Icons.adb_rounded,
                      color: Colors.white, size: 35.0),
                  AppTextStyle().textBold(
                      homeWatch.saleModeDataList![index].saleModeName!,
                      color: Colors.white,
                      size: 16),
                ],
              )),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> errorDialog(BuildContext context, HomeProvider homeWatch) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: CustomErrorWidget(errorMessage: homeWatch.getErrorText)),
          ),
        );
      });
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const LoaddingData();
    },
  );
}
