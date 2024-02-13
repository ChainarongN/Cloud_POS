import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future openTransaction(
      {String? deviceKey,
      String? langID,
      int? saleModeId,
      int? noCustomer}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceKey,
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
    var response = await APIService().postAndParams(
        param: param,
        token: token,
        url: Endpoints.openTran,
        data: data,
        actionBy: 'openTransaction');
    return response;
  }
}
