import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UtilityRepository implements IUtilityRepository {
  @override
  Future endDay(
    BuildContext context,
  ) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': '1',
      'SaleDate': saleDate,
      'ShopID': shopId.toString(),
      'StaffID': staffId.toString(),
      'CloseComputerID': computerId.toString(),
    };

    var response = await APIService().postParams(context,
        url: Endpoints.endDay, token: token, param: param, actionBy: 'endDay');
    return response;
  }

  @override
  Future closeSession(BuildContext context,
      {String? langId, String? closeSSAmount, String? sessionId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String deviceId = await SharedPref().getDeviceId();

    var param = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': langId,
      'SessionID': sessionId,
      'SSComputerID': computerId.toString(),
      'IsEndDaySS': '0',
      'CloseSSAmount': closeSSAmount,
      'ShopID': shopId.toString(),
      'StaffID': staffId.toString()
    };

    var response = await APIService().postParams(context,
        url: Endpoints.closeSession,
        token: token,
        param: param,
        actionBy: 'closeSession');

    return response;
  }

  @override
  Future sessionSearch(BuildContext context, {String? langId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    String deviceId = await SharedPref().getDeviceId();
    int computerId = await SharedPref().getComputerID();
    DateTime now = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd').format(now);

    var param = {
      'reqId': uuid,
      'deviceKey': deviceId,
      'LangID': langId,
      'SessionID': '0',
      'SSComputerID': computerId.toString(),
      'StartDate': formatterDate.toString(),
      'EndDate': formatterDate.toString(),
      'ShopID': shopId.toString(),
      'StaffID': staffId.toString()
    };

    var response = await APIService().postParams(context,
        url: Endpoints.sessionSearch,
        token: token,
        param: param,
        actionBy: 'sessionSearch');

    return response;
  }
}
