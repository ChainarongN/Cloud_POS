class StartProcessModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  ResponseObj2? responseObj2;
  var loyaltyObj;

  StartProcessModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  StartProcessModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];
    pendingReqId = json['PendingReqId'];
    responseObj = json['ResponseObj'] != null
        ? ResponseObj.fromJson(json['ResponseObj'])
        : null;
    responseObj2 = json['ResponseObj2'] != null
        ? ResponseObj2.fromJson(json['ResponseObj2'])
        : null;
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
    if (responseObj2 != null) {
      data['ResponseObj2'] = responseObj2!.toJson();
    }
    data['LoyaltyObj'] = loyaltyObj;
    return data;
  }
}

class ResponseObj {
  int? shopID;
  int? computerID;
  String? saleDate;
  String? shopCode;
  String? shopName;
  String? computerName;
  ActionInfo? actionInfo;

  ResponseObj(
      {this.shopID,
      this.computerID,
      this.saleDate,
      this.shopCode,
      this.shopName,
      this.computerName,
      this.actionInfo});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    shopID = json['ShopID'];
    computerID = json['ComputerID'];
    saleDate = json['SaleDate'];
    shopCode = json['ShopCode'];
    shopName = json['ShopName'];
    computerName = json['ComputerName'];
    actionInfo = json['ActionInfo'] != null
        ? ActionInfo.fromJson(json['ActionInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ShopID'] = shopID;
    data['ComputerID'] = computerID;
    data['SaleDate'] = saleDate;
    data['ShopCode'] = shopCode;
    data['ShopName'] = shopName;
    data['ComputerName'] = computerName;
    if (actionInfo != null) {
      data['ActionInfo'] = actionInfo!.toJson();
    }
    return data;
  }
}

class ActionInfo {
  String? actionCode;
  String? actionName;

  ActionInfo({this.actionCode, this.actionName});

  ActionInfo.fromJson(Map<String, dynamic> json) {
    actionCode = json['ActionCode'];
    actionName = json['ActionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActionCode'] = actionCode;
    data['ActionName'] = actionName;
    return data;
  }
}

class ResponseObj2 {
  HoldBill? holdBill;
  var onlineBill;

  ResponseObj2({this.holdBill, this.onlineBill});

  ResponseObj2.fromJson(Map<String, dynamic> json) {
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
