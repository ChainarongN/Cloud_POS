import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:cloud_pos/service/shared_pref.dart';

class UtilityRepository implements IUtilityRepository {
  @override
  Future endDay({String? deviceKey}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String saleDate = await SharedPref().getSaleDate();

    var param = {
      'reqId': uuid,
      'deviceKey': deviceKey,
      'LangID': '1',
      'SaleDate': saleDate,
      'ShopID': shopId.toString(),
      'StaffID': staffId.toString(),
      'CloseComputerID': computerId.toString(),
    };

    var response = await APIService().postParams(
        url: Endpoints.endDay, token: token, param: param, actionBy: 'endDay');
    return response;
  }

  @override
  Future closeSession(
      {String? langId,
      String? deviceKey,
      String? closeSSAmount,
      String? sessionId}) async {
    String uuid = await SharedPref().getUuid();
    String token = await SharedPref().getToken();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();

    var param = {
      'reqId': uuid,
      'deviceKey': deviceKey,
      'LangID': langId,
      'SessionID': sessionId,
      'SSComputerID': computerId.toString(),
      'IsEndDaySS': '0',
      'CloseSSAmount': closeSSAmount,
      'ShopID': shopId.toString(),
      'StaffID': staffId.toString()
    };

    var response = await APIService().postParams(
        url: Endpoints.closeSession,
        token: token,
        param: param,
        actionBy: 'closeSession');

    return response;
  }
}
