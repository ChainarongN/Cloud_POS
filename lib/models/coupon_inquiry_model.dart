class CouponInquiryModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  CouponInquiryModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  CouponInquiryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];
    pendingReqId = json['PendingReqId'];
    responseObj = json['ResponseObj'] != null
        ? ResponseObj.fromJson(json['ResponseObj'])
        : null;
    responseObj2 = json['ResponseObj2'];
    loyaltyObj = json['LoyaltyObj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['ResponseText'] = responseText;
    data['PendingReqId'] = pendingReqId;
    if (responseObj != null) {
      data['ResponseObj'] = responseObj!.toJson();
    }
    data['ResponseObj2'] = responseObj2;
    data['LoyaltyObj'] = loyaltyObj;
    return data;
  }
}

class ResponseObj {
  String? couponSystem;
  int? voucherID;
  int? vShopID;
  String? voucherSN;
  String? voucherName;
  String? promotionCode;
  String? promotionName;
  String? promotionDesp;
  int? voucherType;
  String? startDate;
  String? expireDate;
  String? voucherAmount;
  String? subsidyCost;
  String? voucherValue;
  int? voucherStatus;
  String? brandKey;
  String? resultText;
  String? imageUrl;

  ResponseObj(
      {this.couponSystem,
      this.voucherID,
      this.vShopID,
      this.voucherSN,
      this.voucherName,
      this.promotionCode,
      this.promotionName,
      this.promotionDesp,
      this.voucherType,
      this.startDate,
      this.expireDate,
      this.voucherAmount,
      this.subsidyCost,
      this.voucherValue,
      this.voucherStatus,
      this.brandKey,
      this.resultText,
      this.imageUrl});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    couponSystem = json['CouponSystem'];
    voucherID = json['VoucherID'];
    vShopID = json['VShopID'];
    voucherSN = json['VoucherSN'];
    voucherName = json['VoucherName'];
    promotionCode = json['PromotionCode'];
    promotionName = json['PromotionName'];
    promotionDesp = json['PromotionDesp'];
    voucherType = json['VoucherType'];
    startDate = json['StartDate'];
    expireDate = json['ExpireDate'];
    voucherAmount = json['VoucherAmount'];
    subsidyCost = json['subsidyCost'];
    voucherValue = json['VoucherValue'];
    voucherStatus = json['VoucherStatus'];
    brandKey = json['BrandKey'];
    resultText = json['ResultText'];
    imageUrl = json['ImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CouponSystem'] = couponSystem;
    data['VoucherID'] = voucherID;
    data['VShopID'] = vShopID;
    data['VoucherSN'] = voucherSN;
    data['VoucherName'] = voucherName;
    data['PromotionCode'] = promotionCode;
    data['PromotionName'] = promotionName;
    data['PromotionDesp'] = promotionDesp;
    data['VoucherType'] = voucherType;
    data['StartDate'] = startDate;
    data['ExpireDate'] = expireDate;
    data['VoucherAmount'] = voucherAmount;
    data['subsidyCost'] = subsidyCost;
    data['VoucherValue'] = voucherValue;
    data['VoucherStatus'] = voucherStatus;
    data['BrandKey'] = brandKey;
    data['ResultText'] = resultText;
    data['ImageUrl'] = imageUrl;
    return data;
  }
}
