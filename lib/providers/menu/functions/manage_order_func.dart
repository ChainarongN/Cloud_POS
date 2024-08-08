// ignore_for_file: use_build_context_synchronously
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/widgets/combo_dialog.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageOrderFunc {
  ManageOrderFunc._internal();
  static final ManageOrderFunc _instance = ManageOrderFunc._internal();
  factory ManageOrderFunc() => _instance;

  Future addProductToList(BuildContext context,
      {int? prodId, double? count, String? orderDetailId}) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    menuPvd.remarkOrderController.text = '';

    await menuPvd.productObj(context, prodId!, orderDetailId!);
    if (menuPvd.apiState == ApiState.COMPLETED) {
      if (menuPvd.productObjModel!.responseObj!.productData != null) {
        var commentList =
            menuPvd.productObjModel!.responseObj!.productData!.comments!;

// ----------------------------------------------  No Comment  --------------------------
        if (commentList.isEmpty) {
          await menuPvd.productAdd(context, count!, false);
          if (menuPvd.apiState == ApiState.COMPLETED) {
            Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
          }
        }
// ---------------------------------------------- Close ---------------------------------
// ---------------------------------------------- Have Comment  -------------------------
        else {
          DialogStyle().commentDialog(context, () async {
            DialogStyle().dialogLoadding(context);
            await menuPvd.productAdd(context, count!, false);
            if (menuPvd.apiState == ApiState.COMPLETED) {
              Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
            }
          });
        }
      }
// ---------------------------------------------- Close ------------------------------
// ---------------------------------------------- Combo set ------------------------
      else {
        ComboDialog().dialog(context, () async {
          DialogStyle().dialogLoadding(context);
          await menuPvd.productAdd(context, count!, true);
          if (menuPvd.apiState == ApiState.COMPLETED) {
            Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
          }
        });
      }
    }
  }

  Future editOrder(BuildContext context, int index) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    String deviceType = await SharedPref().getResponsiveDevice();
    menuPvd.remarkOrderController.text = '';
    int orderDetailId =
        menuPvd.transactionModel!.responseObj!.orderList![index].orderDetailID!;
    double count =
        menuPvd.transactionModel!.responseObj!.orderList![index].qty!;
    int prodId =
        menuPvd.transactionModel!.responseObj!.orderList![index].productID!;
    await menuPvd.productObj(context, prodId, orderDetailId.toString());

    if (menuPvd.productObjModel!.responseObj!.productData != null) {
      var commentList =
          menuPvd.productObjModel!.responseObj!.productData!.comments!;
      if (commentList.isNotEmpty) {
        DialogStyle().commentDialog(context, () async {
          DialogStyle().dialogLoadding(context);
          await menuPvd.productAdd(context, count, false);
          if (menuPvd.apiState == ApiState.COMPLETED) {
            if (deviceType == 'tablet') {
              Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
            } else {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName('/shopingCartPage'));
            }
          }
        });
      }
    } else {
      ComboDialog().dialog(context, () async {
        DialogStyle().dialogLoadding(context);
        await menuPvd.productAdd(context, count, true);
        if (menuPvd.apiState == ApiState.COMPLETED) {
          if (deviceType == 'tablet') {
            Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
          } else {
            Navigator.of(context)
                .popUntil(ModalRoute.withName('/shopingCartPage'));
          }
        }
      });
    }
  }
}
