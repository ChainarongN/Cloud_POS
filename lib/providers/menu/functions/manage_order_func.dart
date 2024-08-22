// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:cloud_pos/models/product_obj_model.dart';
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
          DialogStyle().commentDialog(context, frag: '', () async {
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
        ComboDialog().dialog(context, frag: '', () async {
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
        DialogStyle().commentDialog(context, frag: 'edit', () async {
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
      ComboDialog().dialog(context, frag: 'edit', () async {
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

  Future setSelectComment(BuildContext context, int indexCommentGroup,
      int commentindex, bool selected) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    List<Comments> commentList =
        menuPvd.productObjModel!.responseObj!.productData!.comments!;
    if (menuPvd.productObjModel!.responseObj!.productData!
            .commentGroup![indexCommentGroup].isMulti ==
        0) {
      for (var element in commentList) {
        if (element.groupID ==
            menuPvd.productObjModel!.responseObj!.productData!
                .commentGroup![indexCommentGroup].groupID) {
          element.qty = 0;
        }
      }
    }
    if (selected) {
      menuPvd.productObjModel!.responseObj!.productData!.comments![commentindex]
          .qty = 1.0;
    } else {
      menuPvd.productObjModel!.responseObj!.productData!.comments![commentindex]
          .qty = 0.0;
    }
  }

  Future setSelectCombo(
      BuildContext context,
      bool selected,
      int indexGroup,
      int indexitemList,
      int indexCommentGroup,
      int indexComment,
      bool isComment) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    List<Comments> commentList = menuPvd.productObjModel!.responseObj!
        .comboData!.group![indexGroup].itemList![indexitemList].comments!;

    if (isComment) {
      if (menuPvd.productObjModel!.responseObj!.comboData!
              .commentGroup![indexCommentGroup].isMulti ==
          0) {
        for (var element in commentList) {
          if (element.groupID ==
              menuPvd.productObjModel!.responseObj!.comboData!
                  .commentGroup![indexCommentGroup].groupID) {
            element.qty = 0;
          }
        }
      }
      if (selected) {
        menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].comments![indexComment].qty = 1.0;
      } else {
        menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].comments![indexComment].qty = 0.0;
      }
    } else {
      if (selected) {
        menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].qtyValue = 1.0;
      } else {
        menuPvd.productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].qtyValue = 0.0;
      }
    }
  }

  Future setCountOrder(BuildContext context, int index, String frag) async {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    if (frag == 'add') {
      menuPvd.orderProcess(
          context,
          menuPvd.transactionModel!.responseObj!.orderList![index].qty! + 1,
          menuPvd.transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '2',
          menuPvd.transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    } else if (frag == 'remove') {
      if (menuPvd.transactionModel!.responseObj!.orderList![index].qty! > 1) {
        menuPvd.orderProcess(
            context,
            menuPvd.transactionModel!.responseObj!.orderList![index].qty! - 1,
            menuPvd
                .transactionModel!.responseObj!.orderList![index].orderDetailID
                .toString(),
            '2',
            menuPvd.transactionModel!.responseObj!.orderList![index].productID!
                .toString());
      }
    } else if (frag == 'dialog') {
      menuPvd.orderProcess(
          context,
          double.parse(menuPvd.valueQtyOrderController.text),
          menuPvd.transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '2',
          menuPvd.transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    } else {
      menuPvd.orderProcess(
          context,
          menuPvd.transactionModel!.responseObj!.orderList![index].qty!,
          menuPvd.transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '1',
          menuPvd.transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    }
  }
}
