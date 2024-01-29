import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/networks/end_points.dart';
import 'package:cloud_pos/repositorys/home/i_home_repository.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:uuid/uuid.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future getCoreDataDetail({String? deviceKey, String? langID}) async {
    String uuid = const Uuid().v4();
    String token = await SharedPref().getToken();
    var data = {
      "reqId": uuid,
      "deviceKey": deviceKey,
      "LangID": langID,
    };
    var response = await APIService()
        .postParams(data: data, token: token, url: Endpoints.coreDataInit);
    return response;
  }
}
