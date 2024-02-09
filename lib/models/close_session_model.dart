class CloseSessionModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  CloseSessionModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  CloseSessionModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  var printerName;
  String? key;
  String? dataType;
  String? printDataHtml;
  int? noPrintCopy;

  ResponseObj(
      {this.printerName,
      this.key,
      this.dataType,
      this.printDataHtml,
      this.noPrintCopy});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    printerName = json['PrinterName'];
    key = json['Key'];
    dataType = json['DataType'];
    printDataHtml = json['PrintDataHtml'];
    noPrintCopy = json['NoPrintCopy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['PrinterName'] = printerName;
    data['Key'] = key;
    data['DataType'] = dataType;
    data['PrintDataHtml'] = printDataHtml;
    data['NoPrintCopy'] = noPrintCopy;
    return data;
  }
}
