import 'dart:convert';

import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';

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
    return jsonDecode(response);
  }
}
