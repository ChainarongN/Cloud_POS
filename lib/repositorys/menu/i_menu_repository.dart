abstract class IMenuRepository {
  Future reason({String? langId, String? reasonId});
  Future cancelTran(
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? reasonText});
  Future productObj(
      {String? tranData, String? productId, String? orderDetailId});
  Future productAdd({String? prodObj});
  Future paymentSubmit(
      {String? payAmount,
      var tranData,
      String? payCode,
      String? payName,
      String? currencyCode,
      int? payTypeId,
      int? currencyID,
      String? payRemark});
  Future finalizeBill({String? tranData});
  Future orderSummary({String? orderId});
  Future memberData({String? phoneMember});
  Future memberApply({String? tranData, String? memberId});
  Future memberCancel({String? tranData});
}
