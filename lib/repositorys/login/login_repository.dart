import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:uuid/uuid.dart';

class LoginRepository implements ILoginRepository {
  @override
  Future openSession({String? langID, String? deviceId}) async {
    String token = await SharedPref().getToken();
    String uuid = await SharedPref().getUuid();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();
    var param = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
    };
    var data = json.encode({
      "Action": "add",
      "staffID": staffId,
      "shopID": shopId,
      "computerID": computerId,
      "saleDate": saleDate,
      "openAmount": 1000
    });
    var response = await APIService().postAndParams(
        url: Endpoints.openSession, param: param, token: token, data: data);
    return response;
  }

  @override
  Future startProcess({String? langID, String? deviceId}) async {
    String uuid = await SharedPref().getUuid();
    int staffId = await SharedPref().getStaffID();
    String token = await SharedPref().getToken();
    var data = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': langID,
      'StaffID': staffId.toString(),
    };
    var response = await APIService()
        .postParams(url: Endpoints.startProcess, param: data, token: token);
    return response;
  }

  @override
  Future getCoreDataDetail({String? deviceKey, String? langID}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "LangID": langID,
    };
    var response = await APIService()
        .postParams(param: data, token: token, url: Endpoints.coreDataInit);
    return response;
  }

  @override
  Future authToken(
      {String? clientID, String? grantType, String? clientSecret}) async {
    var data = {
      'client_id': clientID,
      'grant_type': grantType,
      'client_secret': clientSecret
    };
    var response = await APIService().post(Endpoints.authUrl, data);
    return response;
  }

  @override
  Future login(
      {String? deviceKey,
      String? langId,
      String? username,
      String? password}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    if (uuid == '') {
      uuid = const Uuid().v4();
      await SharedPref().setUuid(uuid);
    }

    var data = {
      'reqId': uuid,
      'deviceKey': deviceKey,
      'LangID': langId,
      'username': username,
      'password': password
    };
    var response = await APIService()
        .postParams(param: data, token: token, url: Endpoints.login);

    return response;
  }
}
