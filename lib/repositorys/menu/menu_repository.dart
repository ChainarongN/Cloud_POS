import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/menu/i_menu_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';

class MenuRepository implements IMenuRepository {
  @override
  Future productObj(
      {String? tranData, String? productId, String? deviceKey}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "OrderDetailID": '0',
      "SelProductID": productId,
      "LangID": '1'
    };
    var response = await APIService().postAndParams(
        url: Endpoints.productObj, token: token, param: param, data: tranData);

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
    var response = await APIService()
        .postParams(param: data, token: token, url: Endpoints.reason);
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
    var response = await APIService()
        .postParams(param: data, token: token, url: Endpoints.cancelTran);

    return response;
  }
}
