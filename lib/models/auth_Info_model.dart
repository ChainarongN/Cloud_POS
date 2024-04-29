class AuthInfoModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  List<ResponseObj2>? responseObj2;
  var loyaltyObj;

  AuthInfoModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  AuthInfoModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];
    pendingReqId = json['PendingReqId'];
    responseObj = json['ResponseObj'] != null
        ? ResponseObj.fromJson(json['ResponseObj'])
        : null;
    if (json['ResponseObj2'] != null) {
      responseObj2 = <ResponseObj2>[];
      json['ResponseObj2'].forEach((v) {
        responseObj2!.add(ResponseObj2.fromJson(v));
      });
    }
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
      data['ResponseObj2'] = responseObj2!.map((v) => v.toJson()).toList();
    }
    data['LoyaltyObj'] = loyaltyObj;
    return data;
  }
}

class ResponseObj {
  StaffInfo? staffInfo;
  Null? staffPermission;

  ResponseObj({this.staffInfo, this.staffPermission});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    staffInfo = json['StaffInfo'] != null
        ? StaffInfo.fromJson(json['StaffInfo'])
        : null;
    staffPermission = json['StaffPermission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (staffInfo != null) {
      data['StaffInfo'] = staffInfo!.toJson();
    }
    data['StaffPermission'] = staffPermission;
    return data;
  }
}

class StaffInfo {
  int? staffID;
  int? staffRoleID;
  String? staffRoleName;
  String? staffCode;
  String? staffLogin;
  String? staffGender;
  String? staffFirstName;
  String? staffLastName;
  String? staffMobileNo;
  int? staffLangID;
  String? staffImage;

  StaffInfo(
      {this.staffID,
      this.staffRoleID,
      this.staffRoleName,
      this.staffCode,
      this.staffLogin,
      this.staffGender,
      this.staffFirstName,
      this.staffLastName,
      this.staffMobileNo,
      this.staffLangID,
      this.staffImage});

  StaffInfo.fromJson(Map<String, dynamic> json) {
    staffID = json['StaffID'];
    staffRoleID = json['StaffRoleID'];
    staffRoleName = json['StaffRoleName'];
    staffCode = json['StaffCode'];
    staffLogin = json['StaffLogin'];
    staffGender = json['StaffGender'];
    staffFirstName = json['StaffFirstName'];
    staffLastName = json['StaffLastName'];
    staffMobileNo = json['StaffMobileNo'];
    staffLangID = json['StaffLangID'];
    staffImage = json['StaffImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StaffID'] = staffID;
    data['StaffRoleID'] = staffRoleID;
    data['StaffRoleName'] = staffRoleName;
    data['StaffCode'] = staffCode;
    data['StaffLogin'] = staffLogin;
    data['StaffGender'] = staffGender;
    data['StaffFirstName'] = staffFirstName;
    data['StaffLastName'] = staffLastName;
    data['StaffMobileNo'] = staffMobileNo;
    data['StaffLangID'] = staffLangID;
    data['StaffImage'] = staffImage;
    return data;
  }
}

class ResponseObj2 {
  int? iD;
  String? text;

  ResponseObj2({this.iD, this.text});

  ResponseObj2.fromJson(Map<String, dynamic> json) {
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
