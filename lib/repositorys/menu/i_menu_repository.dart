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
      int? payTypeId,
      int? currencyID,
      String? payRemark});
  Future finalizeBill({String? deviceKey, String? tranData});
  Future orderSummary({String? deviceKey, String? orderId});
}
