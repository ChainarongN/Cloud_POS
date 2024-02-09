import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style.dart';
import 'package:cloud_pos/utils/widgets/loading_data.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              groupMenu(context, dataProvider),
              const VerticalDivider(thickness: 1),
              detailReason(context, dataProvider),
              resultData(context, dataProvider)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: AppTextStyle().textNormal('OK', size: 20),
            onPressed: () async {
              if (dataProvider.getReasonText.text.isNotEmpty ||
                  dataProvider.getReasonController.text.isNotEmpty) {
                LoadingStyle().dialogLoadding(context);
                await dataProvider.cancelTransaction().then((value) {
                  if (dataProvider.apiState == ApiState.ERROR) {
                    Navigator.pop(context);
                    LoadingStyle()
                        .dialogError(context, dataProvider.getExceptionText);
                  } else {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/homePage'));
                  }
                });
              } else {
                dataProvider
                    .setExceptionText('Please select or input your reason');
              }
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

SingleChildScrollView resultData(
    BuildContext context, MenuProvider dataProvider) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Card(
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dataProvider.getReasonController,
                readOnly: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration.collapsed(hintText: ""),
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
              widget: AppTextStyle()
                  .textNormal('Clear', size: 16, color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.27,
          child: TextField(
            controller: dataProvider.getReasonText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              labelText: 'Input your other reason text',
              border: Constants().myColorborder(Constants.textColor),
              enabledBorder: Constants().myColorborder(Constants.textColor),
              focusedBorder: Constants().myColorborder(Constants.textColor),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 25, right: 15),
                child: Icon(Icons.border_color_outlined),
              ),
            ),
            style: const TextStyle(color: Constants.textColor, fontSize: 20),
            maxLines: null,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: AppTextStyle()
              .textNormal(dataProvider.getExceptionText, color: Colors.red),
        ),
      ],
    ),
  );
}

SizedBox detailReason(BuildContext context, MenuProvider dataProvider) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width * 0.44,
    child: SingleChildScrollView(
      child: dataProvider.reasonModel == null
          ? const LoaddingData()
          : Wrap(
              runSpacing: 10,
              children: List.generate(
                dataProvider.reasonModel!.responseObj!.length,
                (index) => GestureDetector(
                  onTap: () => dataProvider.addReasonText(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ContainerStyle(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.135,
                        primaryColor: const Color.fromARGB(255, 255, 104, 190),
                        secondaryColor:
                            const Color.fromARGB(255, 254, 144, 190),
                        selected: false,
                        widget: AppTextStyle().textNormal(
                            dataProvider.reasonModel!.responseObj![index].text!,
                            size: 16,
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
    height: MediaQuery.of(context).size.height,
    child: SingleChildScrollView(
        child: Column(
      children: List.generate(
        dataProvider.reasonGroupList!.length,
        (index) => GestureDetector(
          onTap: () {
            dataProvider.setReason(index).then((value) {
              if (dataProvider.apiState == ApiState.ERROR) {
                LoadingStyle()
                    .dialogError(context, dataProvider.getExceptionText);
              }
            });
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
  );
}
