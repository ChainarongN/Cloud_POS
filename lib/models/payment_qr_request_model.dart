class PaymentQRRequestModel {
  PaymentQRRequestModel({
    required this.responseCode,
    required this.responseText,
    required this.pendingReqId,
    required this.responseObj,
    required this.responseObj2,
    required this.loyaltyObj,
  });

  final String? responseCode;
  final String? responseText;
  final dynamic pendingReqId;
  final ResponseObj? responseObj;
  final dynamic responseObj2;
  final dynamic loyaltyObj;

  factory PaymentQRRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentQRRequestModel(
      responseCode: json["ResponseCode"],
      responseText: json["ResponseText"],
      pendingReqId: json["PendingReqId"],
      responseObj: json["ResponseObj"] == null
          ? null
          : ResponseObj.fromJson(json["ResponseObj"]),
      responseObj2: json["ResponseObj2"],
      loyaltyObj: json["LoyaltyObj"],
    );
  }
}

class ResponseObj {
  ResponseObj({
    required this.orderId,
    required this.txnId,
    required this.qrCode,
    required this.qrImg,
    required this.txnToken,
    required this.status,
    required this.statusMessage,
    required this.createAt,
    required this.custId,
    required this.formUrl,
    required this.amountCustFee,
    required this.amountNet,
    required this.amount,
    required this.currency,
    required this.createdAt,
    required this.qrExpireAt,
    required this.the3Ds,
  });

  final String? orderId;
  final String? txnId;
  final String? qrCode;
  final String? qrImg;
  final String? txnToken;
  final String? status;
  final String? statusMessage;
  final dynamic createAt;
  final String? custId;
  final String? formUrl;
  final double? amountCustFee;
  final double? amountNet;
  final double? amount;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? qrExpireAt;
  final The3Ds? the3Ds;

  factory ResponseObj.fromJson(Map<String, dynamic> json) {
    return ResponseObj(
      orderId: json["order_id"],
      txnId: json["txn_id"],
      qrCode: json["qr_code"],
      qrImg: json["qr_img"],
      txnToken: json["txn_token"],
      status: json["status"],
      statusMessage: json["status_message"],
      createAt: json["create_at"],
      custId: json["cust_id"],
      formUrl: json["form_url"],
      amountCustFee: json["amount_cust_fee"],
      amountNet: json["amount_net"],
      amount: json["amount"],
      currency: json["currency"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      qrExpireAt: DateTime.tryParse(json["qr_expire_at"] ?? ""),
      the3Ds: json["3ds"] == null ? null : The3Ds.fromJson(json["3ds"]),
    );
  }
}

class The3Ds {
  The3Ds({
    required this.the3DsRequired,
  });

  final bool? the3DsRequired;

  factory The3Ds.fromJson(Map<String, dynamic> json) {
    return The3Ds(
      the3DsRequired: json["3ds_required"],
    );
  }
}
