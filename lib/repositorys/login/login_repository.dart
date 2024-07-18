import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:uuid/uuid.dart';

class LoginRepository implements ILoginRepository {
  @override
  Future openSession({String? langID, String? openAmount}) async {
    String token = await SharedPref().getToken();
    String uuid = await SharedPref().getUuid();
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
      "Action": "add",
      "staffID": staffId,
      "shopID": shopId,
      "computerID": computerId,
      "saleDate": saleDate,
      "openAmount": int.parse(openAmount!)
    });
    var response = await APIService().postAndData(
        url: Endpoints.openSession,
        param: param,
        token: token,
        data: data,
        actionBy: 'openSession');
    return response;
  }

  @override
  Future startProcess({String? langID}) async {
    String uuid = await SharedPref().getUuid();
    int staffId = await SharedPref().getStaffID();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    var data = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': langID,
      'StaffID': staffId.toString(),
    };
    var response = await APIService().postParams(
        url: Endpoints.startProcess,
        param: data,
        token: token,
        actionBy: 'startProcess');
    return response;
  }

  @override
  Future getCoreDataDetail({String? langID}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceId,
      "LangID": langID,
    };
    var response = await APIService().postParams(
        param: data,
        token: token,
        url: Endpoints.coreDataInit,
        actionBy: 'getCoreDataDetail');
    return response;
  }

  @override
  Future authToken({String? clientID, String? clientSecret}) async {
    // var data = {
    //   'client_id': clientID,
    //   'grant_type': grantType,
    //   'client_secret': clientSecret
    // };
    var param = {
      'clientId': clientID,
      'clientSecret': clientSecret,
    };
    String uuid = const Uuid().v4();
    await SharedPref().setUuid(uuid);
    var response = await APIService()
        .postToken(param: param, url: Endpoints.authUrl, actionBy: 'Token');
    return response;
  }

  @override
  Future login({String? langId, String? username, String? password}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    String deviceId = await SharedPref().getDeviceId();

    if (uuid.isEmpty) {
      uuid = const Uuid().v4();
      await SharedPref().setUuid(uuid);
    }

    var data = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': langId,
      'username': username,
      'password': password
    };
    var response = await APIService().postParams(
        param: data, token: token, url: Endpoints.login, actionBy: 'login');

    return response;
  }
}
