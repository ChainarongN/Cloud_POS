class MemberDataModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  MemberDataModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  MemberDataModel.fromJson(Map<String, dynamic> json) {
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
  MemberInfo? memberInfo;
  var memberTopMenu;
  var redeemInfo;

  ResponseObj({this.memberInfo, this.memberTopMenu, this.redeemInfo});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    memberInfo = json['MemberInfo'] != null
        ? MemberInfo.fromJson(json['MemberInfo'])
        : null;

    memberTopMenu = json['MemberTopMenu'];
    redeemInfo = json['RedeemInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (memberInfo != null) {
      data['MemberInfo'] = memberInfo!.toJson();
    }
    data['MemberTopMenu'] = memberTopMenu;
    data['RedeemInfo'] = redeemInfo;
    return data;
  }
}

class MemberInfo {
  int? memberGroupID;
  String? memberGroupCode;
  String? memberGroupName;
  int? memberID;
  int? cardID;
  String? memberCode;
  String? memberTitle;
  String? memberNickName;
  String? memberFirstName;
  String? memberLastName;
  String? memberName;
  int? memberGenderID;
  String? memberGenderName;
  String? memberMobile;
  String? memberEmail;
  String? memberExpiration;
  String? memberBirthDay;
  var memberNationalID;
  var memberPassportNo;
  String? memberRegisterDate;
  var memberLastUseDate;
  var memberImage;
  double? memberPoints;
  double? memberCashBalance;
  MemberAddress? memberAddress;
  List<DeliveryAddress>? deliveryAddress;

  MemberInfo(
      {this.memberGroupID,
      this.memberGroupCode,
      this.memberGroupName,
      this.memberID,
      this.cardID,
      this.memberCode,
      this.memberTitle,
      this.memberNickName,
      this.memberFirstName,
      this.memberLastName,
      this.memberName,
      this.memberGenderID,
      this.memberGenderName,
      this.memberMobile,
      this.memberEmail,
      this.memberExpiration,
      this.memberBirthDay,
      this.memberNationalID,
      this.memberPassportNo,
      this.memberRegisterDate,
      this.memberLastUseDate,
      this.memberImage,
      this.memberPoints,
      this.memberCashBalance,
      this.memberAddress,
      this.deliveryAddress});

  MemberInfo.fromJson(Map<String, dynamic> json) {
    memberGroupID = json['MemberGroupID'];
    memberGroupCode = json['MemberGroupCode'];
    memberGroupName = json['MemberGroupName'];
    memberID = json['MemberID'];
    cardID = json['CardID'];
    memberCode = json['MemberCode'];
    memberTitle = json['MemberTitle'];
    memberNickName = json['MemberNickName'];
    memberFirstName = json['MemberFirstName'];
    memberLastName = json['MemberLastName'];
    memberName = json['MemberName'];
    memberGenderID = json['MemberGenderID'];
    memberGenderName = json['MemberGenderName'];
    memberMobile = json['MemberMobile'];
    memberEmail = json['MemberEmail'];
    memberExpiration = json['MemberExpiration'];
    memberBirthDay = json['MemberBirthDay'];
    memberNationalID = json['MemberNationalID'];
    memberPassportNo = json['MemberPassportNo'];
    memberRegisterDate = json['MemberRegisterDate'];
    memberLastUseDate = json['MemberLastUseDate'];
    memberImage = json['MemberImage'];
    memberPoints = json['MemberPoints'];
    memberCashBalance = json['MemberCashBalance'];
    memberAddress = json['MemberAddress'] != null
        ? MemberAddress.fromJson(json['MemberAddress'])
        : null;
    if (json['DeliveryAddress'] != null) {
      deliveryAddress = <DeliveryAddress>[];
      json['DeliveryAddress'].forEach((v) {
        deliveryAddress!.add(DeliveryAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberGroupID'] = memberGroupID;
    data['MemberGroupCode'] = memberGroupCode;
    data['MemberGroupName'] = memberGroupName;
    data['MemberID'] = memberID;
    data['CardID'] = cardID;
    data['MemberCode'] = memberCode;
    data['MemberTitle'] = memberTitle;
    data['MemberNickName'] = memberNickName;
    data['MemberFirstName'] = memberFirstName;
    data['MemberLastName'] = memberLastName;
    data['MemberName'] = memberName;
    data['MemberGenderID'] = memberGenderID;
    data['MemberGenderName'] = memberGenderName;
    data['MemberMobile'] = memberMobile;
    data['MemberEmail'] = memberEmail;
    data['MemberExpiration'] = memberExpiration;
    data['MemberBirthDay'] = memberBirthDay;
    data['MemberNationalID'] = memberNationalID;
    data['MemberPassportNo'] = memberPassportNo;
    data['MemberRegisterDate'] = memberRegisterDate;
    data['MemberLastUseDate'] = memberLastUseDate;
    data['MemberImage'] = memberImage;
    data['MemberPoints'] = memberPoints;
    data['MemberCashBalance'] = memberCashBalance;
    if (memberAddress != null) {
      data['MemberAddress'] = memberAddress!.toJson();
    }
    if (deliveryAddress != null) {
      data['DeliveryAddress'] =
          deliveryAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberAddress {
  var addressNumber;
  String? address1;
  String? address2;
  int? cityID;
  String? city;
  int? provinceID;
  String? provinceName;
  String? zipCode;
  String? country;

  MemberAddress(
      {this.addressNumber,
      this.address1,
      this.address2,
      this.cityID,
      this.city,
      this.provinceID,
      this.provinceName,
      this.zipCode,
      this.country});

  MemberAddress.fromJson(Map<String, dynamic> json) {
    addressNumber = json['AddressNumber'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    cityID = json['CityID'];
    city = json['City'];
    provinceID = json['ProvinceID'];
    provinceName = json['ProvinceName'];
    zipCode = json['ZipCode'];
    country = json['Country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AddressNumber'] = addressNumber;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['CityID'] = cityID;
    data['City'] = city;
    data['ProvinceID'] = provinceID;
    data['ProvinceName'] = provinceName;
    data['ZipCode'] = zipCode;
    data['Country'] = country;
    return data;
  }
}

class DeliveryAddress {
  int? memberID;
  int? addressId;
  String? customerName;
  String? addressName;
  String? addressNumber;
  String? address1;
  String? address2;
  String? addressCity;
  String? addressDistrict;
  String? addressProvince;
  String? addressCountry;
  String? addressZipCode;
  String? addressDirection;
  String? customerMobile;
  String? deliveryNote;
  String? formattedAddress;
  double? latitude;
  double? longitude;
  double? distance;
  var deliveryDate;
  var deliveryFromTime;
  var deliveryToTime;

  DeliveryAddress(
      {this.memberID,
      this.addressId,
      this.customerName,
      this.addressName,
      this.addressNumber,
      this.address1,
      this.address2,
      this.addressCity,
      this.addressDistrict,
      this.addressProvince,
      this.addressCountry,
      this.addressZipCode,
      this.addressDirection,
      this.customerMobile,
      this.deliveryNote,
      this.formattedAddress,
      this.latitude,
      this.longitude,
      this.distance,
      this.deliveryDate,
      this.deliveryFromTime,
      this.deliveryToTime});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    memberID = json['MemberID'];
    addressId = json['AddressId'];
    customerName = json['CustomerName'];
    addressName = json['AddressName'];
    addressNumber = json['AddressNumber'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    addressCity = json['AddressCity'];
    addressDistrict = json['AddressDistrict'];
    addressProvince = json['AddressProvince'];
    addressCountry = json['AddressCountry'];
    addressZipCode = json['AddressZipCode'];
    addressDirection = json['AddressDirection'];
    customerMobile = json['CustomerMobile'];
    deliveryNote = json['DeliveryNote'];
    formattedAddress = json['FormattedAddress'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    distance = json['Distance'];
    deliveryDate = json['DeliveryDate'];
    deliveryFromTime = json['DeliveryFromTime'];
    deliveryToTime = json['DeliveryToTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberID'] = memberID;
    data['AddressId'] = addressId;
    data['CustomerName'] = customerName;
    data['AddressName'] = addressName;
    data['AddressNumber'] = addressNumber;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['AddressCity'] = addressCity;
    data['AddressDistrict'] = addressDistrict;
    data['AddressProvince'] = addressProvince;
    data['AddressCountry'] = addressCountry;
    data['AddressZipCode'] = addressZipCode;
    data['AddressDirection'] = addressDirection;
    data['CustomerMobile'] = customerMobile;
    data['DeliveryNote'] = deliveryNote;
    data['FormattedAddress'] = formattedAddress;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Distance'] = distance;
    data['DeliveryDate'] = deliveryDate;
    data['DeliveryFromTime'] = deliveryFromTime;
    data['DeliveryToTime'] = deliveryToTime;
    return data;
  }
}
