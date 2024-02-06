abstract class ILoginRepository {
  Future authToken({String? clientID, String? grantType, String? clientSecret});
  Future login(
      {String? deviceKey, String? langId, String? username, String? password});
  Future getCoreDataDetail({String? deviceKey, String? langID});
  Future startProcess({String? langID, String? deviceId});
  Future openSession({String? langID, String? deviceId, String? openAmount});
}
