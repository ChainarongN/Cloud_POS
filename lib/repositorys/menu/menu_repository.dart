import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/menu/i_menu_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';

class MenuRepository implements IMenuRepository {
  @override
  Future orderProcess(
      {String? langID,
      String? tranData,
      String? modifyId,
      String? editOrderID,
      String? orderQty,
      String? productID}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "ModifyID": modifyId,
      "EditOrderID": editOrderID,
      "OrderQty": orderQty,
      "ProductID": productID,
      "ProductBarCode": '',
      "StaffID": staffId.toString(),
      "LangID": '1',
      "showProductInfo": 'true'
    };
    var response = await APIService().postAndData(
        url: Endpoints.orderProcess,
        param: param,
        token: token,
        data: tranData,
        actionBy: 'orderProcess');
    return response;
  }

  @override
  Future orderSummary({String? langID, String? orderId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "OrderId": orderId,
      "ViewReceipt": "1",
      "ViewBillSummary": 'true',
      "MoreBillInfo": 'true',
    };
    var response = await APIService().postParams(
        url: Endpoints.orderSummary,
        param: param,
        token: token,
        actionBy: 'orderSummary');

    return response;
  }

  @override
  Future finalizeBill({String? langID, String? tranData}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int computerId = await SharedPref().getComputerID();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "CloseComputerID": computerId.toString(),
      "StaffID": staffId.toString()
    };
    var response = await APIService().postAndData(
        url: Endpoints.finalizeBill,
        param: param,
        token: token,
        data: tranData,
        actionBy: 'finalizeBill');
    return response;
  }

  @override
  Future paymentSubmit(
      {String? langID,
      String? payAmount,
      var tranData,
      String? payCode,
      String? payName,
      String? currencyCode,
      int? payTypeId,
      int? currencyID,
      String? payRemark}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "ViewOrderInfo": 'true',
    };

    var data = {
      "payTypeID": payTypeId,
      "payTypeCode": payCode,
      "payTypeName": payName,
      "edcType": 0,
      "payRemark": payRemark,
      "currencyID": currencyID,
      "currencyCode": currencyCode,
      "customerCode": '',
      "edcResponse": '',
      "staffID": staffId,
      "payAmount": double.parse(payAmount!),
      "tranData": jsonDecode(tranData),
      "ccInfo": null,
      "voucherInfo": null
    };

    var response = await APIService().postAndData(
        url: Endpoints.paymenySubmit,
        param: param,
        token: token,
        data: data,
        actionBy: 'paymentSubmit');

    return response;
  }

  @override
  Future productAdd({String? langID, String? prodObj}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "ViewOrderInfo": 'true',
    };
    var response = await APIService().postAndData(
        url: Endpoints.productAdd,
        param: param,
        token: token,
        data: prodObj,
        actionBy: 'productAdd');

    return response;
  }

  @override
  Future productObj(
      {String? langID,
      String? tranData,
      String? productId,
      String? orderDetailId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "OrderDetailID": orderDetailId,
      "SelProductID": productId,
      "LangID": '1'
    };
    var response = await APIService().postAndData(
        url: Endpoints.productObj,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'productObj');

    return response;
  }

  @override
  Future memberData({String? langID, String? phoneMember}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "memberCode": phoneMember
    };
    var response = await APIService().postParams(
        url: Endpoints.memberData,
        token: token,
        param: param,
        actionBy: 'memberData');

    return response;
  }

  @override
  Future memberApply(
      {String? langID, String? tranData, String? memberId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "MemberID": memberId,
      "ViewOrderInfo": true
    };
    var response = await APIService().postAndData(
        url: Endpoints.memberApply,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'memberApply');

    return response;
  }

  @override
  Future memberCancel({String? langID, String? tranData}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": '1',
      "ViewOrderInfo": true
    };
    var response = await APIService().postAndData(
        url: Endpoints.memberCancel,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'memberCancel');

    return response;
  }

  @override
  Future reason({String? langId, String? reasonId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int shopId = await SharedPref().getShopID();
    int staffId = await SharedPref().getStaffID();
    String deviceId = await SharedPref().getDeviceId();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langId,
      "ReasonGroupID": reasonId,
      "ShopID": shopId.toString(),
      "StaffID": staffId.toString()
    };
    var response = await APIService().postParams(
        param: data, token: token, url: Endpoints.reason, actionBy: 'reason');
    return response;
  }

  @override
  Future cancelTran(
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? reasonText}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String saleDate = await SharedPref().getSaleDate();
    int staffId = await SharedPref().getStaffID();
    String deviceId = await SharedPref().getDeviceId();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langId,
      "OrderId": orderId,
      "ReasonIDList": reasonIDList,
      "ReasonText": reasonText,
      "StaffID": staffId.toString(),
      "TodayDate": saleDate
    };
    var response = await APIService().postParams(
        param: data,
        token: token,
        url: Endpoints.cancelTran,
        actionBy: 'cancelTran');

    return response;
  }

  @override
  Future eCouponInquiry({
    String? langID,
    String? voucherSN,
    int? transactionID,
    String? computerCode,
    String? computerName,
    String? tranKey,
    String? shopCode,
    String? shopName,
    String? shopKey,
    String? staffCode,
    String? staffName,
  }) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    int staffId = await SharedPref().getStaffID();
    String saleDate = await SharedPref().getSaleDate();
    String staffCode = await SharedPref().getStaffCode();
    String staffRoleName = await SharedPref().getStaffRoleName();

    var param = {"reqId": uuid, "deviceKey": deviceId, "LangID": langID};
    var data = {
      "requestID": uuid,
      "voucherID": 0,
      "vShopID": 0,
      "voucherSN": voucherSN,
      "transactionID": transactionID,
      "computerID": computerId,
      "computerCode": computerCode,
      "computerName": computerName,
      "tranKey": tranKey,
      "shopCode": shopCode,
      "shopID": shopId,
      "shopName": shopName,
      "shopKey": shopKey,
      "saleDate": saleDate,
      "receiptNumber": "",
      "receiptPayPrice": 0,
      "staffID": staffId,
      "staffCode": staffCode,
      "staffName": staffRoleName,
      "memberID": 0,
      "cardID": 0,
      "memberCode": "",
      "memberName": "",
      "couponRedeem": ""
    };

    var response = await APIService().postAndData(
        url: Endpoints.eCouponInquiry,
        token: token,
        param: param,
        data: data,
        actionBy: 'eCoupon_Inquiry');

    return response;
  }

  @override
  Future eCouponApply(
      {String? langID, String? couponSN, String? tranData}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
      "CouponSN": couponSN,
      "ViewOrderInfo": "true"
    };

    var response = await APIService().postAndData(
        url: Endpoints.eCouponApply,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'eCoupon_Apply');

    return response;
  }

  @override
  Future promotionCancel(
      {String? langID, String? promoUUID, String? tranData}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
      "PromoUUID": promoUUID,
      "ViewOrderInfo": "true"
    };

    var response = await APIService().postAndData(
        url: Endpoints.promotionCancel,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'Promotion_Cancel');

    return response;
  }
}
