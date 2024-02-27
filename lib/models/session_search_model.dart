class SessionSearch {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  List<ResponseObj>? responseObj;
  var responseObj2;
  var loyaltyObj;

  SessionSearch(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  SessionSearch.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];
    pendingReqId = json['PendingReqId'];
    if (json['ResponseObj'] != null) {
      responseObj = <ResponseObj>[];
      json['ResponseObj'].forEach((v) {
        responseObj!.add(ResponseObj.fromJson(v));
      });
    }
    responseObj2 = json['ResponseObj2'];
    loyaltyObj = json['LoyaltyObj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['ResponseText'] = responseText;
    data['PendingReqId'] = pendingReqId;
    if (responseObj != null) {
      data['ResponseObj'] = responseObj!.map((v) => v.toJson()).toList();
    }
    data['ResponseObj2'] = responseObj2;
    data['LoyaltyObj'] = loyaltyObj;
    return data;
  }
}

class ResponseObj {
  int? sessionID;
  int? computerID;
  String? sessionKey;
  String? computerName;
  String? openStaff;
  String? closeStaff;
  String? openTime;
  String? closeTime;
  String? saleDate;
  double? openAmt;
  double? cashAmt;
  double? cashInAmt;
  double? cashOutAmt;
  double? dropCashAmt;
  double? closeAmt;
  double? shortOverAmt;
  String? updateDate;
  int? shopID;
  int? isEndDay;

  ResponseObj(
      {this.sessionID,
      this.computerID,
      this.sessionKey,
      this.computerName,
      this.openStaff,
      this.closeStaff,
      this.openTime,
      this.closeTime,
      this.saleDate,
      this.openAmt,
      this.cashAmt,
      this.cashInAmt,
      this.cashOutAmt,
      this.dropCashAmt,
      this.closeAmt,
      this.shortOverAmt,
      this.updateDate,
      this.shopID,
      this.isEndDay});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    sessionID = json['SessionID'];
    computerID = json['ComputerID'];
    sessionKey = json['SessionKey'];
    computerName = json['ComputerName'];
    openStaff = json['OpenStaff'];
    closeStaff = json['CloseStaff'];
    openTime = json['OpenTime'];
    closeTime = json['CloseTime'];
    saleDate = json['SaleDate'];
    openAmt = json['OpenAmt'];
    cashAmt = json['CashAmt'];
    cashInAmt = json['CashInAmt'];
    cashOutAmt = json['CashOutAmt'];
    dropCashAmt = json['DropCashAmt'];
    closeAmt = json['CloseAmt'];
    shortOverAmt = json['ShortOverAmt'];
    updateDate = json['UpdateDate'];
    shopID = json['ShopID'];
    isEndDay = json['IsEndDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SessionID'] = sessionID;
    data['ComputerID'] = computerID;
    data['SessionKey'] = sessionKey;
    data['ComputerName'] = computerName;
    data['OpenStaff'] = openStaff;
    data['CloseStaff'] = closeStaff;
    data['OpenTime'] = openTime;
    data['CloseTime'] = closeTime;
    data['SaleDate'] = saleDate;
    data['OpenAmt'] = openAmt;
    data['CashAmt'] = cashAmt;
    data['CashInAmt'] = cashInAmt;
    data['CashOutAmt'] = cashOutAmt;
    data['DropCashAmt'] = dropCashAmt;
    data['CloseAmt'] = closeAmt;
    data['ShortOverAmt'] = shortOverAmt;
    data['UpdateDate'] = updateDate;
    data['ShopID'] = shopID;
    data['IsEndDay'] = isEndDay;
    return data;
  }
}
