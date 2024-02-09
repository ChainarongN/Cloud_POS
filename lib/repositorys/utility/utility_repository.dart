import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:cloud_pos/utils/shared_pref.dart';

class UtilityRepository implements IUtilityRepository {
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

    var response = await APIService()
        .postParams(url: Endpoints.closeSession, token: token, param: param);

    return response;
  }
}
