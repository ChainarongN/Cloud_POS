abstract class IMenuRepository {
  Future paymentCancel({String? langID, String? tranData, String? payDetailId});
  Future authInfo(
      {String? langID, String? authType, String? username, String? password});
  Future reason({String? langId, String? reasonId});
  Future cancelTran(
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? reasonText,
      String? staffId});
  Future productObj(
      {String? langID,
      String? tranData,
      String? productId,
      String? orderDetailId});
  Future productAdd({String? langID, String? prodObj});
  Future paymentSubmit(
      {String? langID,
      String? payAmount,
      var tranData,
      String? payCode,
      String? payName,
      String? currencyCode,
      int? payTypeId,
      int? currencyID,
      String? payRemark});
  Future finalizeBill({String? langID, String? tranData});
  Future orderSummary({String? langID, String? orderId});
  Future memberData({String? langID, String? phoneMember});
  Future memberApply({String? langID, String? tranData, String? memberId});
  Future memberCancel({String? langID, String? tranData});
  Future eCouponInquiry(
      {String? langID,
      String? voucherSN,
      int? transactionID,
      String? computerCode,
      String? computerName,
      String? tranKey,
      String? shopCode,
      String? shopName,
      String? shopKey,
      String? staffCode,
      String? staffName});
  Future eCouponApply({String? langID, String? couponSN, String? tranData});
  Future promotionCancel({String? langID, String? promoUUID, String? tranData});
  Future orderProcess(
      {String? langID,
      String? tranData,
      String? modifyId,
      String? editOrderID,
      String? orderQty,
      String? productID});
  Future holdBill(
      {String? langID,
      String? orderId,
      String? customerName,
      String? customerMobile});
  Future paymentQRRequest({
    String? langID,
    var tranData,
    int? payTypeId,
    String? payTypeCode,
    String? payTypeName,
    int? edcType,
    String? payRemark,
    int? currencyID,
    String? currencyCode,
    double? payAmount,
  });
  Future paymentQRInquiry({
    String? langID,
    var tranData,
    int? payTypeId,
    String? payTypeCode,
    String? payTypeName,
    int? edcType,
    String? payRemark,
    int? currencyID,
    String? currencyCode,
    double? payAmount,
  });
  Future paymentQRCancel({
    String? langID,
    var tranData,
    int? payTypeId,
    String? payTypeCode,
    String? payTypeName,
    int? edcType,
    String? payRemark,
    int? currencyID,
    String? currencyCode,
    double? payAmount,
  });
}
