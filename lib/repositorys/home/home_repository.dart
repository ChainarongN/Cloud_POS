import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future authToken(
      {String? clientID, String? grantType, String? clientSecret}) async {
    var data = {
      'client_id': clientID,
      'grant_type': grantType,
      'client_secret': clientSecret
    };
    await APIService().post(Endpoints.authUrl, data);
  }
}
