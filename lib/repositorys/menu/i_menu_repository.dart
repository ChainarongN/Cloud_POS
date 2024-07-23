import 'package:flutter/material.dart';

abstract class IMenuRepository {
  Future receiptBillPrint(BuildContext context,
      {String? langID, String? orderId});
  Future paymentCancel(BuildContext context,
      {String? langID, String? tranData, String? payDetailId});
  Future authInfo(BuildContext context,
      {String? langID, String? authType, String? username, String? password});
  Future reason(BuildContext context, {String? langId, String? reasonId});
  Future cancelTran(BuildContext context,
      {String? orderId,
      String? reasonIDList,
      String? langId,
      String? reasonText,
      String? staffId});
  Future productObj(BuildContext context,
      {String? langID,
      String? tranData,
      String? productId,
      String? orderDetailId});
  Future productAdd(BuildContext context, {String? langID, String? prodObj});
  Future paymentSubmit(BuildContext context,
      {String? langID,
      String? payAmount,
      var tranData,
      String? payCode,
      String? payName,
      String? currencyCode,
      int? payTypeId,
      int? currencyID,
      String? payRemark});
  Future finalizeBill(BuildContext context, {String? langID, String? tranData});
  Future orderSummary(BuildContext context, {String? langID, String? orderId});
  Future memberData(BuildContext context,
      {String? langID, String? phoneMember});
  Future memberApply(BuildContext context,
      {String? langID, String? tranData, String? memberId});
  Future memberCancel(BuildContext context, {String? langID, String? tranData});
  Future eCouponInquiry(BuildContext context,
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
  Future eCouponApply(BuildContext context,
      {String? langID, String? couponSN, String? tranData});
  Future promotionCancel(BuildContext context,
      {String? langID, String? promoUUID, String? tranData});
  Future orderProcess(BuildContext context,
      {String? langID,
      String? tranData,
      String? modifyId,
      String? editOrderID,
      String? orderQty,
      String? productID});
  Future holdBill(BuildContext context,
      {String? langID,
      String? orderId,
      String? customerName,
      String? customerMobile});
  Future paymentQRRequest(
    BuildContext context, {
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
  Future paymentQRInquiry(
    BuildContext context, {
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
  Future paymentQRCancel(
    BuildContext context, {
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
