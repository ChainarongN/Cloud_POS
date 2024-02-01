abstract class ILoginRepository {
  Future authToken({String? clientID, String? grantType, String? clientSecret});
  Future login(
      {String? deviceKey, String? langId, String? username, String? password});
  Future getCoreDataDetail({String? deviceKey, String? langID});
}
