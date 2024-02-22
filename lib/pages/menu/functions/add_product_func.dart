// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_pos/models/product_add_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductFunc {
  AddProductFunc._internal();
  static final AddProductFunc _instance = AddProductFunc._internal();
  factory AddProductFunc() => _instance;

  Future<bool> addProductToList(BuildContext context,
      {int? prodId, double? count, String? orderDetailId}) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    bool isSuccess = false;

    await menuProvider.productObj(context, prodId!, orderDetailId!);
    await menuProvider.productAdd(context, count!);
    if (menuProvider.apiState == ApiState.COMPLETED) {
      isSuccess = true;
      Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
    }
    return isSuccess;
  }

  Future<ProductAddModel> detectProductAdd(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    ProductAddModel? productAddModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        productAddModel = ProductAddModel.fromJson(jsonDecode(response));
        if (productAddModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'productAdd');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: productAddModel.responseText,
              isPopUntil: true,
              popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }
    return productAddModel!;
  }

  Future<ProductObjModel> detectProductObj(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    ProductObjModel? productObjModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        productObjModel = ProductObjModel.fromJson(jsonDecode(response));
        if (productObjModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'productObj');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: productObjModel.responseText,
              isPopUntil: true,
              popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }
    return productObjModel!;
  }
}
