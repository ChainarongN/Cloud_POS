class PaymentQRRequestModel {
  String? responseCode;
  String? responseText;
  Null? pendingReqId;
  ResponseObj? responseObj;
  Null? responseObj2;
  Null? loyaltyObj;

  PaymentQRRequestModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  PaymentQRRequestModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];
    pendingReqId = json['PendingReqId'];
    responseObj = json['ResponseObj'] != null
        ? new ResponseObj.fromJson(json['ResponseObj'])
        : null;
    responseObj2 = json['ResponseObj2'];
    loyaltyObj = json['LoyaltyObj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['ResponseText'] = this.responseText;
    data['PendingReqId'] = this.pendingReqId;
    if (this.responseObj != null) {
      data['ResponseObj'] = this.responseObj!.toJson();
    }
    data['ResponseObj2'] = this.responseObj2;
    data['LoyaltyObj'] = this.loyaltyObj;
    return data;
  }
}

class ResponseObj {
  String? orderId;
  String? txnId;
  String? qrCode;
  String? qrImg;
  double? amount;
  double? amountNet;
  double? amountCustFee;
  String? currency;
  String? createdAt;
  String? qrExpireAt;

  ResponseObj(
      {this.orderId,
      this.txnId,
      this.qrCode,
      this.qrImg,
      this.amount,
      this.amountNet,
      this.amountCustFee,
      this.currency,
      this.createdAt,
      this.qrExpireAt});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    txnId = json['txn_id'];
    qrCode = json['qr_code'];
    qrImg = json['qr_img'];
    amount = json['amount'];
    amountNet = json['amount_net'];
    amountCustFee = json['amount_cust_fee'];
    currency = json['currency'];
    createdAt = json['created_at'];
    qrExpireAt = json['qr_expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['txn_id'] = this.txnId;
    data['qr_code'] = this.qrCode;
    data['qr_img'] = this.qrImg;
    data['amount'] = this.amount;
    data['amount_net'] = this.amountNet;
    data['amount_cust_fee'] = this.amountCustFee;
    data['currency'] = this.currency;
    data['created_at'] = this.createdAt;
    data['qr_expire_at'] = this.qrExpireAt;
    return data;
  }
}
