abstract class IUtilityRepository {
  Future closeSession(
      {String? langId, String? closeSSAmount, String? sessionId});
  Future endDay();
  Future sessionSearch({String? langId});
}
