// ignore_for_file: use_build_context_synchronously
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductFunc {
  AddProductFunc._internal();
  static final AddProductFunc _instance = AddProductFunc._internal();
  factory AddProductFunc() => _instance;

  Future addProductToList(BuildContext context,
      {int? prodId, double? count, String? orderDetailId}) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    menuPvd.remarkOrderController.text = '';

    await menuPvd.productObj(context, prodId!, orderDetailId!);
    if (menuPvd.apiState == ApiState.COMPLETED) {
      if (menuPvd.productObjModel!.responseObj!.productData != null) {
        bool commentEmpty = menuPvd
                .productObjModel!.responseObj!.productData!.comments!.length ==
            1;
        bool commentGroupId = menuPvd.productObjModel!.responseObj!.productData!
                .comments!.first.groupID ==
            -1;
// ----------------------------------------------  No Comment  --------------------------
        if (commentEmpty && commentGroupId) {
          await menuPvd.productAdd(context, count!);
          if (menuPvd.apiState == ApiState.COMPLETED) {
            Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
          }
        }
// ---------------------------------------------- Close ---------------------------------
// ---------------------------------------------- Have Comment  -------------------------
        else {
          DialogStyle().commentDialog(context, () async {
            DialogStyle().dialogLoadding(context);
            if (menuPvd.remarkOrderController.text.isNotEmpty) {
              int lengthComment = menuPvd
                  .productObjModel!.responseObj!.productData!.comments!.length;
              for (var i = 0; i < lengthComment; i++) {
                if (menuPvd.productObjModel!.responseObj!.productData!
                        .comments![i].groupID ==
                    -1) {
                  menuPvd
                      .productObjModel!
                      .responseObj!
                      .productData!
                      .comments![i]
                      .commentText = menuPvd.remarkOrderController.text;
                  menuPvd.productObjModel!.responseObj!.productData!
                      .comments![i].qty = 1.0;
                }
              }
            }
            await menuPvd.productAdd(context, count!);
            if (menuPvd.apiState == ApiState.COMPLETED) {
              Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
            }
          });
        }
      }
// ---------------------------------------------- Close ------------------------------
// ---------------------------------------------- Combo set ------------------------
      else {
        ////////////  is Combo wait dev
        Constants().printError('This way is Product Combo');
        Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
      }
    }
  }
}
