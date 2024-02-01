import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:uuid/uuid.dart';

class LoginRepository implements ILoginRepository {
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
      String uuid = const Uuid().v4();
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
}
