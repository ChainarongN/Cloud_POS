import 'dart:convert';

import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/finalize_bill_model.dart';
import 'package:cloud_pos/models/order_summary_model.dart';
import 'package:cloud_pos/models/payment_submit_model.dart';
import 'package:cloud_pos/models/product_add_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectMenuFunc {
  DetectMenuFunc._internal();
  static final DetectMenuFunc _instance = DetectMenuFunc._internal();
  factory DetectMenuFunc() => _instance;

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

  Future<FinalizeBillModel> detectFinalizeBill(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    FinalizeBillModel? finalizeBillModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        finalizeBillModel = FinalizeBillModel.fromJson(jsonDecode(response));
        if (finalizeBillModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'finalizeBill');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: finalizeBillModel.responseText,
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
    return finalizeBillModel!;
  }

  Future<OrderSummaryModel> detectOrderSummary(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    OrderSummaryModel? orderSummaryModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        orderSummaryModel = OrderSummaryModel.fromJson(jsonDecode(response));
        if (orderSummaryModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'orderSummary');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: orderSummaryModel.responseText,
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
    return orderSummaryModel!;
  }

  Future<PaymentSubmitModel> detectPaymentSubmit(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    PaymentSubmitModel? paymentSubmitModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        paymentSubmitModel = PaymentSubmitModel.fromJson(jsonDecode(response));
        if (paymentSubmitModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'paymentSubmit');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: paymentSubmitModel.responseText,
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
    return paymentSubmitModel!;
  }

  Future<CancelTranModel> detectCancelTran(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    CancelTranModel? cancelTranModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingStyle()
              .dialogError(context,
                  error: response.errorResponse.toString(), isPopUntil: false)
              .then((value) => Navigator.of(context)
                  .popUntil(ModalRoute.withName('/homePage')));
        });
      } else {
        cancelTranModel = CancelTranModel.fromJson(jsonDecode(response));
        if (cancelTranModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'CancelTransaction');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          Navigator.pop(context);
          Future.delayed(const Duration(milliseconds: 500), () {
            LoadingStyle()
                .dialogError(context,
                    error: cancelTranModel!.responseText, isPopUntil: false)
                .then((value) => Navigator.of(context)
                    .popUntil(ModalRoute.withName('/homePage')));
          });
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingStyle()
            .dialogError(context, error: e.toString(), isPopUntil: false)
            .then((value) => Navigator.of(context)
                .popUntil(ModalRoute.withName('/homePage')));
      });
    }
    return cancelTranModel!;
  }

  Future<ReasonModel> detectReason(BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    ReasonModel? reasonModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingStyle().dialogError(context,
              error: response.errorResponse.toString(), isPopUntil: false);
        });
      } else {
        reasonModel = ReasonModel.fromJson(jsonDecode(response));
        if (reasonModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'reason');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          Future.delayed(const Duration(milliseconds: 500), () {
            LoadingStyle().dialogError(context,
                error: reasonModel!.responseText, isPopUntil: false);
          });
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingStyle()
            .dialogError(context, error: e.toString(), isPopUntil: false);
      });
    }
    return reasonModel!;
  }
}
