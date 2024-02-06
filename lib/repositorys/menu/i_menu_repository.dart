abstract class IMenuRepository {
  Future reason({String? deviceKey, String? langId, String? reasonId});
  Future cancelTran(
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? deviceKey});
}
