import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future unHoldBill({String? langID, String? orderId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
      "OrderId": orderId,
      "StaffID": staffId,
    };
    var response = await APIService().postParams(
        param: param,
        token: token,
        url: Endpoints.unHoldBill,
        actionBy: 'unHoldBill');
    return response;
  }

  @override
  Future holdBillSearch({String? langID}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
      "SaleDate": saleDate,
      "ShopID": shopId,
      "StaffID": staffId,
      "ComputerID": computerId
    };
    var response = await APIService().postParams(
        param: param,
        token: token,
        url: Endpoints.holdBillSearch,
        actionBy: 'holdBillSearch');
    return response;
  }

  @override
  Future openTransaction(
      {String? langID, int? saleModeId, int? noCustomer}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();
    String deviceId = await SharedPref().getDeviceId();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
    };
    var data = json.encode({
      "staffID": staffId,
      "shopID": shopId,
      "computerID": computerId,
      "saleDate": saleDate,
      "saleModeID": saleModeId,
      "memberID": 0,
      "queueName": "",
      "tableID": 0,
      "noCustomer": noCustomer,
      "customerName": ""
    });
    var response = await APIService().postAndData(
        param: param,
        token: token,
        url: Endpoints.openTran,
        data: data,
        actionBy: 'openTransaction');
    return response;
  }
}
