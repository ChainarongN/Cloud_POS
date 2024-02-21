import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/menu/i_menu_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';

class MenuRepository implements IMenuRepository {
  @override
  Future orderSummary({String? deviceKey, String? orderId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();

    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
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
  Future finalizeBill({String? deviceKey, String? tranData}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int computerId = await SharedPref().getComputerID();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "LangID": '1',
      "CloseComputerID": computerId.toString(),
      "StaffID": staffId.toString()
    };
    var response = await APIService().postAndParams(
        url: Endpoints.finalizeBill,
        param: param,
        token: token,
        data: tranData,
        actionBy: 'finalizeBill');
    return response;
  }

  @override
  Future paymentSubmit(
      {String? deviceKey,
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

    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
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
      "tranData": tranData,
      "ccInfo": null,
      "voucherInfo": null
    };

    var response = await APIService().postAndParams(
        url: Endpoints.paymenySubmit,
        param: param,
        token: token,
        data: data,
        actionBy: 'paymentSubmit');

    return response;
  }

  @override
  Future productAdd({String? deviceKey, String? prodObj}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "LangID": '1',
      "ViewOrderInfo": 'true',
    };
    var response = await APIService().postAndParams(
        url: Endpoints.productAdd,
        param: param,
        token: token,
        data: prodObj,
        actionBy: 'productAdd');

    return response;
  }

  @override
  Future productObj(
      {String? tranData,
      String? productId,
      String? deviceKey,
      String? orderDetailId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "OrderDetailID": orderDetailId,
      "SelProductID": productId,
      "LangID": '1'
    };
    var response = await APIService().postAndParams(
        url: Endpoints.productObj,
        token: token,
        param: param,
        data: tranData,
        actionBy: 'productObj');

    return response;
  }

  @override
  Future reason({String? deviceKey, String? langId, String? reasonId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int shopId = await SharedPref().getShopID();
    int staffId = await SharedPref().getStaffID();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceKey,
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
      String? deviceKey,
      String? reasonText}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String saleDate = await SharedPref().getSaleDate();
    int staffId = await SharedPref().getStaffID();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceKey,
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
}
