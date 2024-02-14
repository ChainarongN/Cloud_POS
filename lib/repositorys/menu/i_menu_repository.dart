abstract class IMenuRepository {
  Future reason({String? deviceKey, String? langId, String? reasonId});
  Future cancelTran(
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? deviceKey,
      String? reasonText});
  Future productObj(
      {String? tranData,
      String? productId,
      String? deviceKey,
      String? orderDetailId});
  Future productAdd({String? deviceKey, String? prodObj});
  Future paymentSubmit(
      {String? deviceKey,
      String? payAmount,
      var tranData,
      String? payCode,
      String? payName,
      String? currencyCode,
      int? payId});
  Future finalizeBill(
      {String? deviceKey, String? tranData, String? computerId});
}
