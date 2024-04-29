import 'dart:ffi';

class HoldBillModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  HoldBillModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  HoldBillModel.fromJson(Map<String, dynamic> json) {
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
  HoldBill? holdBill;
  var onlineBill;

  ResponseObj({this.holdBill, this.onlineBill});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    holdBill =
        json['HoldBill'] != null ? HoldBill.fromJson(json['HoldBill']) : null;
    onlineBill = json['OnlineBill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holdBill != null) {
      data['HoldBill'] = holdBill!.toJson();
    }
    data['OnlineBill'] = onlineBill;
    return data;
  }
}

class HoldBill {
  int? totalBill;
  double? totalAmt;

  HoldBill({this.totalBill, this.totalAmt});

  HoldBill.fromJson(Map<String, dynamic> json) {
    totalBill = json['TotalBill'];
    totalAmt = json['TotalAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalBill'] = totalBill;
    data['TotalAmt'] = totalAmt;
    return data;
  }
}
