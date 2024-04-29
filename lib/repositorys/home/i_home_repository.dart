abstract class IHomeRepository {
  Future openTransaction({String? langID, int? saleModeId, int? noCustomer});
  Future holdBillSearch({String? langID});
  Future unHoldBill({String? langID, String? orderId});
}
