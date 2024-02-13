abstract class IUtilityRepository {
  Future closeSession(
      {String? langId,
      String? deviceKey,
      String? closeSSAmount,
      String? sessionId});
  Future endDay({String? deviceKey});
}
