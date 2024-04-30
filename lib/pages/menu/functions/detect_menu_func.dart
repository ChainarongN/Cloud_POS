import 'dart:convert';
import 'package:cloud_pos/models/auth_Info_model.dart';
import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/coupon_inquiry_model.dart';
import 'package:cloud_pos/models/hold_bill_model.dart';
import 'package:cloud_pos/models/member_data_model.dart';
import 'package:cloud_pos/models/transaction_model.dart';
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

  // Future<ProductAddModel> detectProductAdd(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   ProductAddModel? productAddModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       LoadingStyle().dialogError(context,
  //           error: response.errorResponse.toString(),
  //           isPopUntil: true,
  //           popToPage: '/menuPage');
  //     } else {
  //       productAddModel = ProductAddModel.fromJson(jsonDecode(response));
  //       if (productAddModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'productAdd');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         LoadingStyle().dialogError(context,
  //             error: productAddModel.responseText,
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     LoadingStyle().dialogError(context,
  //         error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //   }
  //   return productAddModel!;
  // }
  Future<AuthInfoModel> detectAuthInfo(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    AuthInfoModel? authInfoModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        authInfoModel = AuthInfoModel.fromJson(jsonDecode(response));
        if (authInfoModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'AuthInfoModel');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: authInfoModel.responseText,
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
    return authInfoModel!;
  }

  Future<HoldBillModel> detectHoldBill(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    HoldBillModel? holdBillModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        holdBillModel = HoldBillModel.fromJson(jsonDecode(response));
        if (holdBillModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'holdBill');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: holdBillModel.responseText,
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
    return holdBillModel!;
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

  // Future<FinalizeBillModel> detectFinalizeBill(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   FinalizeBillModel? finalizeBillModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       LoadingStyle().dialogError(context,
  //           error: response.errorResponse.toString(),
  //           isPopUntil: true,
  //           popToPage: '/menuPage');
  //     } else {
  //       finalizeBillModel = FinalizeBillModel.fromJson(jsonDecode(response));
  //       if (finalizeBillModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'finalizeBill');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         LoadingStyle().dialogError(context,
  //             error: finalizeBillModel.responseText,
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     LoadingStyle().dialogError(context,
  //         error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //   }
  //   return finalizeBillModel!;
  // }

  Future<TransactionModel> detectTransaction(
      BuildContext context, var response, String action) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    TransactionModel? transactionModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/menuPage');
      } else {
        if (jsonDecode(response)['ResponseCode'] == "") {
          transactionModel = TransactionModel.fromJson(jsonDecode(response));
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, action);
        } else {
          menuProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: jsonDecode(response)['ResponseText'],
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
    return transactionModel!;
  }

  // Future<PaymentSubmitModel> detectPaymentSubmit(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   PaymentSubmitModel? paymentSubmitModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       LoadingStyle().dialogError(context,
  //           error: response.errorResponse.toString(),
  //           isPopUntil: true,
  //           popToPage: '/menuPage');
  //     } else {
  //       paymentSubmitModel = PaymentSubmitModel.fromJson(jsonDecode(response));
  //       if (paymentSubmitModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'paymentSubmit');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         LoadingStyle().dialogError(context,
  //             error: paymentSubmitModel.responseText,
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     LoadingStyle().dialogError(context,
  //         error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //   }
  //   return paymentSubmitModel!;
  // }

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

  Future<MemberDataModel> detectMemberData(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    MemberDataModel? memberDataModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingStyle().dialogError(context,
              error: response.errorResponse.toString(),
              isPopUntil: true,
              popToPage: '/menuPage');
        });
      } else {
        memberDataModel = MemberDataModel.fromJson(jsonDecode(response));
        if (memberDataModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'MemberData');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          Future.delayed(const Duration(milliseconds: 500), () {
            LoadingStyle().dialogError(context,
                error: memberDataModel!.responseText,
                isPopUntil: true,
                popToPage: '/menuPage');
          });
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingStyle().dialogError(context,
            error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
      });
    }
    return memberDataModel!;
  }

  // Future<MemberApplyModel> detectMemberApply(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   MemberApplyModel? memberApplyModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       Future.delayed(const Duration(milliseconds: 500), () {
  //         LoadingStyle().dialogError(context,
  //             error: response.errorResponse.toString(),
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       });
  //     } else {
  //       memberApplyModel = MemberApplyModel.fromJson(jsonDecode(response));
  //       if (memberApplyModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'MemberApply');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         Future.delayed(const Duration(milliseconds: 500), () {
  //           LoadingStyle().dialogError(context,
  //               error: memberApplyModel!.responseText,
  //               isPopUntil: true,
  //               popToPage: '/menuPage');
  //         });
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       LoadingStyle().dialogError(context,
  //           error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //     });
  //   }
  //   return memberApplyModel!;
  // }

  // Future<MemberCancelModel> detectMemberCancel(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   MemberCancelModel? memberCancelModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       Future.delayed(const Duration(milliseconds: 500), () {
  //         LoadingStyle().dialogError(context,
  //             error: response.errorResponse.toString(),
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       });
  //     } else {
  //       memberCancelModel = MemberCancelModel.fromJson(jsonDecode(response));
  //       if (memberCancelModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'MemberCancel');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         Future.delayed(const Duration(milliseconds: 500), () {
  //           LoadingStyle().dialogError(context,
  //               error: memberCancelModel!.responseText,
  //               isPopUntil: true,
  //               popToPage: '/menuPage');
  //         });
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       LoadingStyle().dialogError(context,
  //           error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //     });
  //   }
  //   return memberCancelModel!;
  // }

  Future<CouponInquiryModel> detectCouponInquiry(
      BuildContext context, var response) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);
    CouponInquiryModel? couponInquiryModel;
    try {
      if (response is Failure) {
        menuProvider.apiState = ApiState.ERROR;
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingStyle().dialogError(context,
              error: response.errorResponse.toString(),
              isPopUntil: true,
              popToPage: '/menuPage');
        });
      } else {
        couponInquiryModel = CouponInquiryModel.fromJson(jsonDecode(response));
        if (couponInquiryModel.responseCode!.isEmpty) {
          menuProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'eCouponInquiry');
        } else {
          menuProvider.apiState = ApiState.ERROR;
          Future.delayed(const Duration(milliseconds: 500), () {
            LoadingStyle().dialogError(context,
                error: couponInquiryModel!.responseText,
                isPopUntil: true,
                popToPage: '/menuPage');
          });
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      menuProvider.apiState = ApiState.ERROR;
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingStyle().dialogError(context,
            error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
      });
    }
    return couponInquiryModel!;
  }

  // Future<CouponApplyModel> detectCouponApply(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   CouponApplyModel? couponApplyModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       Future.delayed(const Duration(milliseconds: 500), () {
  //         LoadingStyle().dialogError(context,
  //             error: response.errorResponse.toString(),
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       });
  //     } else {
  //       if (jsonDecode(response)['ResponseCode'] == "") {
  //         couponApplyModel = CouponApplyModel.fromJson(jsonDecode(response));
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'eCouponApply');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         Future.delayed(const Duration(milliseconds: 500), () {
  //           LoadingStyle().dialogError(context,
  //               error: jsonDecode(response)['ResponseText'],
  //               isPopUntil: true,
  //               popToPage: '/menuPage');
  //         });
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       LoadingStyle().dialogError(context,
  //           error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //     });
  //   }
  //   return couponApplyModel!;
  // }

  // Future<PromotionCancelModel> detectPromotionCancel(
  //     BuildContext context, var response) async {
  //   var menuProvider = Provider.of<MenuProvider>(context, listen: false);
  //   PromotionCancelModel? promotionCancelModel;
  //   try {
  //     if (response is Failure) {
  //       menuProvider.apiState = ApiState.ERROR;
  //       Future.delayed(const Duration(milliseconds: 500), () {
  //         LoadingStyle().dialogError(context,
  //             error: response.errorResponse.toString(),
  //             isPopUntil: true,
  //             popToPage: '/menuPage');
  //       });
  //     } else {
  //       promotionCancelModel =
  //           PromotionCancelModel.fromJson(jsonDecode(response));
  //       if (promotionCancelModel.responseCode!.isEmpty) {
  //         menuProvider.apiState = ApiState.COMPLETED;
  //         Constants().printCheckFlow(response, 'Promotion_Cancel');
  //       } else {
  //         menuProvider.apiState = ApiState.ERROR;
  //         Future.delayed(const Duration(milliseconds: 500), () {
  //           LoadingStyle().dialogError(context,
  //               error: promotionCancelModel!.responseText,
  //               isPopUntil: true,
  //               popToPage: '/menuPage');
  //         });
  //       }
  //     }
  //   } catch (e, strack) {
  //     Constants().printError('$e - $strack');
  //     menuProvider.apiState = ApiState.ERROR;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       LoadingStyle().dialogError(context,
  //           error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
  //     });
  //   }
  //   return promotionCancelModel!;
  // }
}
