class HoldBillSearchModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  List<ResponseObj>? responseObj;
  var responseObj2;
  var loyaltyObj;

  HoldBillSearchModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  HoldBillSearchModel.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  int? transactionID;
  int? computerID;
  String? tranKey;
  int? shopID;
  String? saleDate;
  String? openTime;
  String? customerName;
  String? customerMobile;
  String? referenceNo;
  int? saleMode;
  String? saleModeName;
  int? saleModeTypeID;
  double? receiptTotalQty;
  double? receiptNetSale;

  ResponseObj(
      {this.orderId,
      this.transactionID,
      this.computerID,
      this.tranKey,
      this.shopID,
      this.saleDate,
      this.openTime,
      this.customerName,
      this.customerMobile,
      this.referenceNo,
      this.saleMode,
      this.saleModeName,
      this.saleModeTypeID,
      this.receiptTotalQty,
      this.receiptNetSale});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    transactionID = json['TransactionID'];
    computerID = json['ComputerID'];
    tranKey = json['TranKey'];
    shopID = json['ShopID'];
    saleDate = json['SaleDate'];
    openTime = json['OpenTime'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    referenceNo = json['ReferenceNo'];
    saleMode = json['SaleMode'];
    saleModeName = json['SaleModeName'];
    saleModeTypeID = json['SaleModeTypeID'];
    receiptTotalQty = json['ReceiptTotalQty'];
    receiptNetSale = json['ReceiptNetSale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderId'] = orderId;
    data['TransactionID'] = transactionID;
    data['ComputerID'] = computerID;
    data['TranKey'] = tranKey;
    data['ShopID'] = shopID;
    data['SaleDate'] = saleDate;
    data['OpenTime'] = openTime;
    data['CustomerName'] = customerName;
    data['CustomerMobile'] = customerMobile;
    data['ReferenceNo'] = referenceNo;
    data['SaleMode'] = saleMode;
    data['SaleModeName'] = saleModeName;
    data['SaleModeTypeID'] = saleModeTypeID;
    data['ReceiptTotalQty'] = receiptTotalQty;
    data['ReceiptNetSale'] = receiptNetSale;
    return data;
  }
}
