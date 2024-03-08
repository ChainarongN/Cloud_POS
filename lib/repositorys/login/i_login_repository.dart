abstract class ILoginRepository {
  Future authToken({String? clientID, String? grantType, String? clientSecret});
  Future login({String? langId, String? username, String? password});
  Future getCoreDataDetail({String? langID});
  Future startProcess({String? langID});
  Future openSession({String? langID, String? openAmount});
}
