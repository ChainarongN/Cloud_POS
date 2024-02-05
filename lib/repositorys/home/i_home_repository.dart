abstract class IHomeRepository {
  Future openTransaction(
      {String? deviceKey, String? langID, int? saleModeId, int? noCustomer});
}
