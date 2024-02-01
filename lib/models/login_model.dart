class LoginModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  LoginModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  StaffInfo? staffInfo;
  List<StaffPermission>? staffPermission;

  ResponseObj({this.staffInfo, this.staffPermission});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    staffInfo = json['StaffInfo'] != null
        ? StaffInfo.fromJson(json['StaffInfo'])
        : null;
    if (json['StaffPermission'] != null) {
      staffPermission = <StaffPermission>[];
      json['StaffPermission'].forEach((v) {
        staffPermission!.add(StaffPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (staffInfo != null) {
      data['StaffInfo'] = staffInfo!.toJson();
    }
    if (staffPermission != null) {
      data['StaffPermission'] =
          staffPermission!.map((v) => v.toJson()).toList();
    }
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

class StaffPermission {
  int? staffRoleID;
  int? permissionItemID;
  String? permissionItemName;

  StaffPermission(
      {this.staffRoleID, this.permissionItemID, this.permissionItemName});

  StaffPermission.fromJson(Map<String, dynamic> json) {
    staffRoleID = json['StaffRoleID'];
    permissionItemID = json['PermissionItemID'];
    permissionItemName = json['PermissionItemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StaffRoleID'] = staffRoleID;
    data['PermissionItemID'] = permissionItemID;
    data['PermissionItemName'] = permissionItemName;
    return data;
  }
}
