class ReasonModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  List<ResponseObj>? responseObj;
  var responseObj2;
  var loyaltyObj;

  ReasonModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  ReasonModel.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  String? text;

  ResponseObj({this.iD, this.text});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Text'] = text;
    return data;
  }
}
