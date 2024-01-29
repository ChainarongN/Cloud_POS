class CoreInitModel {
  String? responseCode;
  String? responseText;

  ResponseObj? responseObj;

  CoreInitModel({
    this.responseCode,
    this.responseText,
    this.responseObj,
  });

  CoreInitModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseText = json['ResponseText'];

    responseObj = json['ResponseObj'] != null
        ? ResponseObj.fromJson(json['ResponseObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['ResponseText'] = responseText;

    if (responseObj != null) {
      data['ResponseObj'] = responseObj!.toJson();
    }

    return data;
  }
}

class ResponseObj {
  ShopData? shopData;
  ComputerName? computerName;
  List<SaleModeData>? saleModeData;
  PayTypeData? payTypeData;
  ProductData? productData;
  List<FavoriteGroup>? favoriteGroup;
  List<FavoriteData>? favoriteData;
  PropertyInfo? propertyInfo;
  Resources? resources;
  List<ReasonGroup>? reasonGroup;

  ResponseObj(
      {this.shopData,
      this.computerName,
      this.saleModeData,
      this.payTypeData,
      this.productData,
      this.favoriteGroup,
      this.favoriteData,
      this.propertyInfo,
      this.resources,
      this.reasonGroup});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    shopData =
        json['ShopData'] != null ? ShopData.fromJson(json['ShopData']) : null;
    computerName = json['ComputerName'] != null
        ? ComputerName.fromJson(json['ComputerName'])
        : null;
    if (json['SaleModeData'] != null) {
      saleModeData = <SaleModeData>[];
      json['SaleModeData'].forEach((v) {
        saleModeData!.add(SaleModeData.fromJson(v));
      });
    }
    payTypeData = json['PayTypeData'] != null
        ? PayTypeData.fromJson(json['PayTypeData'])
        : null;
    productData = json['ProductData'] != null
        ? ProductData.fromJson(json['ProductData'])
        : null;
    if (json['FavoriteGroup'] != null) {
      favoriteGroup = <FavoriteGroup>[];
      json['FavoriteGroup'].forEach((v) {
        favoriteGroup!.add(FavoriteGroup.fromJson(v));
      });
    }
    if (json['FavoriteData'] != null) {
      favoriteData = <FavoriteData>[];
      json['FavoriteData'].forEach((v) {
        favoriteData!.add(FavoriteData.fromJson(v));
      });
    }
    propertyInfo = json['PropertyInfo'] != null
        ? PropertyInfo.fromJson(json['PropertyInfo'])
        : null;
    resources = json['Resources'] != null
        ? Resources.fromJson(json['Resources'])
        : null;
    if (json['ReasonGroup'] != null) {
      reasonGroup = <ReasonGroup>[];
      json['ReasonGroup'].forEach((v) {
        reasonGroup!.add(ReasonGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopData != null) {
      data['ShopData'] = shopData!.toJson();
    }
    if (computerName != null) {
      data['ComputerName'] = computerName!.toJson();
    }
    if (saleModeData != null) {
      data['SaleModeData'] = saleModeData!.map((v) => v.toJson()).toList();
    }
    if (payTypeData != null) {
      data['PayTypeData'] = payTypeData!.toJson();
    }
    if (productData != null) {
      data['ProductData'] = productData!.toJson();
    }
    if (favoriteGroup != null) {
      data['FavoriteGroup'] = favoriteGroup!.map((v) => v.toJson()).toList();
    }
    if (favoriteData != null) {
      data['FavoriteData'] = favoriteData!.map((v) => v.toJson()).toList();
    }
    if (propertyInfo != null) {
      data['PropertyInfo'] = propertyInfo!.toJson();
    }
    if (resources != null) {
      data['Resources'] = resources!.toJson();
    }
    if (reasonGroup != null) {
      data['ReasonGroup'] = reasonGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopData {
  int? outletID;
  int? shopID;
  int? shopTypeID;
  String? shopKey;
  String? brandKey;
  String? brandName;
  String? merchantKey;
  String? merchantName;
  String? shopCode;
  String? shopName;
  String? openHour;
  String? closeHour;
  String? storeAddress1;
  String? storeAddress2;
  String? storeAddress3;
  String? storePhoneNo;
  String? storeRemark;
  String? subscribeExpireDate;
  Resources? resources;

  ShopData(
      {this.outletID,
      this.shopID,
      this.shopTypeID,
      this.shopKey,
      this.brandKey,
      this.brandName,
      this.merchantKey,
      this.merchantName,
      this.shopCode,
      this.shopName,
      this.openHour,
      this.closeHour,
      this.storeAddress1,
      this.storeAddress2,
      this.storeAddress3,
      this.storePhoneNo,
      this.storeRemark,
      this.subscribeExpireDate,
      this.resources});

  ShopData.fromJson(Map<String, dynamic> json) {
    outletID = json['OutletID'];
    shopID = json['ShopID'];
    shopTypeID = json['ShopTypeID'];
    shopKey = json['ShopKey'];
    brandKey = json['BrandKey'];
    brandName = json['BrandName'];
    merchantKey = json['MerchantKey'];
    merchantName = json['MerchantName'];
    shopCode = json['ShopCode'];
    shopName = json['ShopName'];
    openHour = json['OpenHour'];
    closeHour = json['CloseHour'];
    storeAddress1 = json['StoreAddress1'];
    storeAddress2 = json['StoreAddress2'];
    storeAddress3 = json['StoreAddress3'];
    storePhoneNo = json['StorePhoneNo'];
    storeRemark = json['StoreRemark'];
    subscribeExpireDate = json['SubscribeExpireDate'];
    resources = json['Resources'] != null
        ? Resources.fromJson(json['Resources'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OutletID'] = outletID;
    data['ShopID'] = shopID;
    data['ShopTypeID'] = shopTypeID;
    data['ShopKey'] = shopKey;
    data['BrandKey'] = brandKey;
    data['BrandName'] = brandName;
    data['MerchantKey'] = merchantKey;
    data['MerchantName'] = merchantName;
    data['ShopCode'] = shopCode;
    data['ShopName'] = shopName;
    data['OpenHour'] = openHour;
    data['CloseHour'] = closeHour;
    data['StoreAddress1'] = storeAddress1;
    data['StoreAddress2'] = storeAddress2;
    data['StoreAddress3'] = storeAddress3;
    data['StorePhoneNo'] = storePhoneNo;
    data['StoreRemark'] = storeRemark;
    data['SubscribeExpireDate'] = subscribeExpireDate;
    if (resources != null) {
      data['Resources'] = resources!.toJson();
    }
    return data;
  }
}

class Resources {
  String? loginUrl;
  String? logoUrl;

  Resources({this.loginUrl, this.logoUrl});

  Resources.fromJson(Map<String, dynamic> json) {
    loginUrl = json['LoginUrl'];
    logoUrl = json['LogoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LoginUrl'] = loginUrl;
    data['LogoUrl'] = logoUrl;
    return data;
  }
}

class ComputerName {
  int? computerID;
  String? deviceKey;
  String? computerName;
  int? computerType;
  int? kDSID;
  String? kDSPrinters;
  String? payTypeList;
  String? saleModeList;
  String? productGroupList;

  ComputerName(
      {this.computerID,
      this.deviceKey,
      this.computerName,
      this.computerType,
      this.kDSID,
      this.kDSPrinters,
      this.payTypeList,
      this.saleModeList,
      this.productGroupList});

  ComputerName.fromJson(Map<String, dynamic> json) {
    computerID = json['ComputerID'];
    deviceKey = json['DeviceKey'];
    computerName = json['ComputerName'];
    computerType = json['ComputerType'];
    kDSID = json['KDSID'];
    kDSPrinters = json['KDSPrinters'];
    payTypeList = json['PayTypeList'];
    saleModeList = json['SaleModeList'];
    productGroupList = json['ProductGroupList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ComputerID'] = computerID;
    data['DeviceKey'] = deviceKey;
    data['ComputerName'] = computerName;
    data['ComputerType'] = computerType;
    data['KDSID'] = kDSID;
    data['KDSPrinters'] = kDSPrinters;
    data['PayTypeList'] = payTypeList;
    data['SaleModeList'] = saleModeList;
    data['ProductGroupList'] = productGroupList;
    return data;
  }
}

class SaleModeData {
  int? saleModeID;
  String? saleModeName;
  int? positionPrefix;
  String? saleModePrefix;
  int? saleModeTypeID;
  String? payTypeList;
  String? notInPayTypeList;
  int? isDefault;

  SaleModeData(
      {this.saleModeID,
      this.saleModeName,
      this.positionPrefix,
      this.saleModePrefix,
      this.saleModeTypeID,
      this.payTypeList,
      this.notInPayTypeList,
      this.isDefault});

  SaleModeData.fromJson(Map<String, dynamic> json) {
    saleModeID = json['SaleModeID'];
    saleModeName = json['SaleModeName'];
    positionPrefix = json['PositionPrefix'];
    saleModePrefix = json['SaleModePrefix'];
    saleModeTypeID = json['SaleModeTypeID'];
    payTypeList = json['PayTypeList'];
    notInPayTypeList = json['NotInPayTypeList'];
    isDefault = json['IsDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SaleModeID'] = saleModeID;
    data['SaleModeName'] = saleModeName;
    data['PositionPrefix'] = positionPrefix;
    data['SaleModePrefix'] = saleModePrefix;
    data['SaleModeTypeID'] = saleModeTypeID;
    data['PayTypeList'] = payTypeList;
    data['NotInPayTypeList'] = notInPayTypeList;
    data['IsDefault'] = isDefault;
    return data;
  }
}

class PayTypeData {
  List<PayTypeInfo>? payTypeInfo;
  List<PayTypeGroupData>? payTypeGroupData;
  List<CurrencyInfo>? currencyInfo;

  List<PaymentButton>? paymentButton;

  PayTypeData(
      {this.payTypeInfo,
      this.payTypeGroupData,
      this.currencyInfo,
      this.paymentButton});

  PayTypeData.fromJson(Map<String, dynamic> json) {
    if (json['PayTypeInfo'] != null) {
      payTypeInfo = <PayTypeInfo>[];
      json['PayTypeInfo'].forEach((v) {
        payTypeInfo!.add(PayTypeInfo.fromJson(v));
      });
    }
    if (json['PayTypeGroupData'] != null) {
      payTypeGroupData = <PayTypeGroupData>[];
      json['PayTypeGroupData'].forEach((v) {
        payTypeGroupData!.add(PayTypeGroupData.fromJson(v));
      });
    }
    if (json['CurrencyInfo'] != null) {
      currencyInfo = <CurrencyInfo>[];
      json['CurrencyInfo'].forEach((v) {
        currencyInfo!.add(CurrencyInfo.fromJson(v));
      });
    }

    if (json['PaymentButton'] != null) {
      paymentButton = <PaymentButton>[];
      json['PaymentButton'].forEach((v) {
        paymentButton!.add(PaymentButton.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payTypeInfo != null) {
      data['PayTypeInfo'] = payTypeInfo!.map((v) => v.toJson()).toList();
    }
    if (payTypeGroupData != null) {
      data['PayTypeGroupData'] =
          payTypeGroupData!.map((v) => v.toJson()).toList();
    }
    if (currencyInfo != null) {
      data['CurrencyInfo'] = currencyInfo!.map((v) => v.toJson()).toList();
    }

    if (paymentButton != null) {
      data['PaymentButton'] = paymentButton!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayTypeInfo {
  int? payTypeID;
  int? payTypeGroupID;
  String? payTypeCode;
  String? payTypeName;
  String? displayName;
  String? payTypeImage;
  int? eDCType;
  int? voucherType;
  int? isOtherReceipt;
  double? defaultPayAmt;
  int? isRequire;
  int? isFixPrice;
  int? isOpenDrawer;
  int? isAuth;
  String? payTypeFlow;
  int? ordering;

  PayTypeInfo(
      {this.payTypeID,
      this.payTypeGroupID,
      this.payTypeCode,
      this.payTypeName,
      this.displayName,
      this.payTypeImage,
      this.eDCType,
      this.voucherType,
      this.isOtherReceipt,
      this.defaultPayAmt,
      this.isRequire,
      this.isFixPrice,
      this.isOpenDrawer,
      this.isAuth,
      this.payTypeFlow,
      this.ordering});

  PayTypeInfo.fromJson(Map<String, dynamic> json) {
    payTypeID = json['PayTypeID'];
    payTypeGroupID = json['PayTypeGroupID'];
    payTypeCode = json['PayTypeCode'];
    payTypeName = json['PayTypeName'];
    displayName = json['DisplayName'];
    payTypeImage = json['PayTypeImage'];
    eDCType = json['EDCType'];
    voucherType = json['VoucherType'];
    isOtherReceipt = json['IsOtherReceipt'];
    defaultPayAmt = json['DefaultPayAmt'];
    isRequire = json['IsRequire'];
    isFixPrice = json['IsFixPrice'];
    isOpenDrawer = json['IsOpenDrawer'];
    isAuth = json['IsAuth'];
    payTypeFlow = json['PayTypeFlow'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PayTypeID'] = payTypeID;
    data['PayTypeGroupID'] = payTypeGroupID;
    data['PayTypeCode'] = payTypeCode;
    data['PayTypeName'] = payTypeName;
    data['DisplayName'] = displayName;
    data['PayTypeImage'] = payTypeImage;
    data['EDCType'] = eDCType;
    data['VoucherType'] = voucherType;
    data['IsOtherReceipt'] = isOtherReceipt;
    data['DefaultPayAmt'] = defaultPayAmt;
    data['IsRequire'] = isRequire;
    data['IsFixPrice'] = isFixPrice;
    data['IsOpenDrawer'] = isOpenDrawer;
    data['IsAuth'] = isAuth;
    data['PayTypeFlow'] = payTypeFlow;
    data['Ordering'] = ordering;
    return data;
  }
}

class PayTypeGroupData {
  int? payTypeGroupID;
  String? payTypeGroupName;
  int? ordering;

  PayTypeGroupData({this.payTypeGroupID, this.payTypeGroupName, this.ordering});

  PayTypeGroupData.fromJson(Map<String, dynamic> json) {
    payTypeGroupID = json['PayTypeGroupID'];
    payTypeGroupName = json['PayTypeGroupName'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PayTypeGroupID'] = payTypeGroupID;
    data['PayTypeGroupName'] = payTypeGroupName;
    data['Ordering'] = ordering;
    return data;
  }
}

class CurrencyInfo {
  int? currencyID;
  String? currencyCode;
  String? currencyName;
  String? countryName;
  int? isMain;
  int? isChange;

  CurrencyInfo(
      {this.currencyID,
      this.currencyCode,
      this.currencyName,
      this.countryName,
      this.isMain,
      this.isChange});

  CurrencyInfo.fromJson(Map<String, dynamic> json) {
    currencyID = json['CurrencyID'];
    currencyCode = json['CurrencyCode'];
    currencyName = json['CurrencyName'];
    countryName = json['CountryName'];
    isMain = json['IsMain'];
    isChange = json['IsChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CurrencyID'] = currencyID;
    data['CurrencyCode'] = currencyCode;
    data['CurrencyName'] = currencyName;
    data['CountryName'] = countryName;
    data['IsMain'] = isMain;
    data['IsChange'] = isChange;
    return data;
  }
}

class PaymentButton {
  int? currencyID;
  double? paymentAmount;
  String? imageUrl;
  int? ordering;

  PaymentButton(
      {this.currencyID, this.paymentAmount, this.imageUrl, this.ordering});

  PaymentButton.fromJson(Map<String, dynamic> json) {
    currencyID = json['CurrencyID'];
    paymentAmount = json['PaymentAmount'];
    imageUrl = json['ImageUrl'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CurrencyID'] = currencyID;
    data['PaymentAmount'] = paymentAmount;
    data['ImageUrl'] = imageUrl;
    data['Ordering'] = ordering;
    return data;
  }
}

class ProductData {
  List<ProductGroup>? productGroup;
  List<ProductDept>? productDept;
  List<Products>? products;

  List<ProductSM>? productSM;

  ProductData(
      {this.productGroup, this.productDept, this.products, this.productSM});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['ProductGroup'] != null) {
      productGroup = <ProductGroup>[];
      json['ProductGroup'].forEach((v) {
        productGroup!.add(ProductGroup.fromJson(v));
      });
    }
    if (json['ProductDept'] != null) {
      productDept = <ProductDept>[];
      json['ProductDept'].forEach((v) {
        productDept!.add(ProductDept.fromJson(v));
      });
    }
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productGroup != null) {
      data['ProductGroup'] = productGroup!.map((v) => v.toJson()).toList();
    }
    if (productDept != null) {
      data['ProductDept'] = productDept!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }

    if (productSM != null) {
      data['ProductSM'] = productSM!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductGroup {
  int? productGroupID;
  String? productGroupCode;
  String? productGroupName;
  int? isComment;
  int? ordering;

  ProductGroup(
      {this.productGroupID,
      this.productGroupCode,
      this.productGroupName,
      this.isComment,
      this.ordering});

  ProductGroup.fromJson(Map<String, dynamic> json) {
    productGroupID = json['ProductGroupID'];
    productGroupCode = json['ProductGroupCode'];
    productGroupName = json['ProductGroupName'];
    isComment = json['IsComment'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductGroupID'] = productGroupID;
    data['ProductGroupCode'] = productGroupCode;
    data['ProductGroupName'] = productGroupName;
    data['IsComment'] = isComment;
    data['Ordering'] = ordering;
    return data;
  }
}

class ProductDept {
  int? productGroupID;
  int? productDeptID;
  String? productDeptCode;
  String? productDeptName;
  int? ordering;

  ProductDept(
      {this.productGroupID,
      this.productDeptID,
      this.productDeptCode,
      this.productDeptName,
      this.ordering});

  ProductDept.fromJson(Map<String, dynamic> json) {
    productGroupID = json['ProductGroupID'];
    productDeptID = json['ProductDeptID'];
    productDeptCode = json['ProductDeptCode'];
    productDeptName = json['ProductDeptName'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductGroupID'] = productGroupID;
    data['ProductDeptID'] = productDeptID;
    data['ProductDeptCode'] = productDeptCode;
    data['ProductDeptName'] = productDeptName;
    data['Ordering'] = ordering;
    return data;
  }
}

class Products {
  int? productID;
  int? productTypeID;
  int? productGroupID;
  int? productDeptID;
  String? productCode;
  String? productName;
  String? imageFileName;
  String? productDesp;
  int? vATType;
  String? vATCode;
  String? unitName;
  double? productPrice;
  int? isRetail;
  String? fromTime1;
  String? toTime1;
  String? fromTime2;
  String? toTime2;
  String? fromTime3;
  String? toTime3;
  int? ordering;

  Products(
      {this.productID,
      this.productTypeID,
      this.productGroupID,
      this.productDeptID,
      this.productCode,
      this.productName,
      this.imageFileName,
      this.productDesp,
      this.vATType,
      this.vATCode,
      this.unitName,
      this.productPrice,
      this.isRetail,
      this.fromTime1,
      this.toTime1,
      this.fromTime2,
      this.toTime2,
      this.fromTime3,
      this.toTime3,
      this.ordering});

  Products.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    productTypeID = json['ProductTypeID'];
    productGroupID = json['ProductGroupID'];
    productDeptID = json['ProductDeptID'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    imageFileName = json['ImageFileName'];
    productDesp = json['ProductDesp'];
    vATType = json['VATType'];
    vATCode = json['VATCode'];
    unitName = json['UnitName'];
    productPrice = json['ProductPrice'];
    isRetail = json['IsRetail'];
    fromTime1 = json['FromTime1'];
    toTime1 = json['ToTime1'];
    fromTime2 = json['FromTime2'];
    toTime2 = json['ToTime2'];
    fromTime3 = json['FromTime3'];
    toTime3 = json['ToTime3'];
    ordering = json['Ordering'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductID'] = productID;
    data['ProductTypeID'] = productTypeID;
    data['ProductGroupID'] = productGroupID;
    data['ProductDeptID'] = productDeptID;
    data['ProductCode'] = productCode;
    data['ProductName'] = productName;
    data['ImageFileName'] = imageFileName;
    data['ProductDesp'] = productDesp;
    data['VATType'] = vATType;
    data['VATCode'] = vATCode;
    data['UnitName'] = unitName;
    data['ProductPrice'] = productPrice;
    data['IsRetail'] = isRetail;
    data['FromTime1'] = fromTime1;
    data['ToTime1'] = toTime1;
    data['FromTime2'] = fromTime2;
    data['ToTime2'] = toTime2;
    data['FromTime3'] = fromTime3;
    data['ToTime3'] = toTime3;
    data['Ordering'] = ordering;
    return data;
  }
}

class ProductSM {
  int? pID;
  int? sMID;
  int? sMVal;

  ProductSM({this.pID, this.sMID, this.sMVal});

  ProductSM.fromJson(Map<String, dynamic> json) {
    pID = json['PID'];
    sMID = json['SMID'];
    sMVal = json['SMVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PID'] = pID;
    data['SMID'] = sMID;
    data['SMVal'] = sMVal;
    return data;
  }
}

class FavoriteGroup {
  int? templateID;
  int? pageIndex;
  String? pageName;
  String? hexColor;
  int? pageType;
  int? pageOrder;

  FavoriteGroup(
      {this.templateID,
      this.pageIndex,
      this.pageName,
      this.hexColor,
      this.pageType,
      this.pageOrder});

  FavoriteGroup.fromJson(Map<String, dynamic> json) {
    templateID = json['TemplateID'];
    pageIndex = json['PageIndex'];
    pageName = json['PageName'];
    hexColor = json['HexColor'];
    pageType = json['PageType'];
    pageOrder = json['PageOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TemplateID'] = templateID;
    data['PageIndex'] = pageIndex;
    data['PageName'] = pageName;
    data['HexColor'] = hexColor;
    data['PageType'] = pageType;
    data['PageOrder'] = pageOrder;
    return data;
  }
}

class FavoriteData {
  int? templateID;
  int? pageIndex;
  int? productID;
  String? productCode;
  String? hexColor;
  int? buttonOrder;

  FavoriteData(
      {this.templateID,
      this.pageIndex,
      this.productID,
      this.productCode,
      this.hexColor,
      this.buttonOrder});

  FavoriteData.fromJson(Map<String, dynamic> json) {
    templateID = json['TemplateID'];
    pageIndex = json['PageIndex'];
    productID = json['ProductID'];
    productCode = json['ProductCode'];
    hexColor = json['HexColor'];
    buttonOrder = json['ButtonOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TemplateID'] = templateID;
    data['PageIndex'] = pageIndex;
    data['ProductID'] = productID;
    data['ProductCode'] = productCode;
    data['HexColor'] = hexColor;
    data['ButtonOrder'] = buttonOrder;
    return data;
  }
}

class PropertyInfo {
  FrontLayout? frontLayout;
  FrontResource? frontResource;
  List<PropertyData>? propertyData;

  PropertyInfo({this.frontLayout, this.frontResource, this.propertyData});

  PropertyInfo.fromJson(Map<String, dynamic> json) {
    frontLayout = json['FrontLayout'] != null
        ? FrontLayout.fromJson(json['FrontLayout'])
        : null;
    frontResource = json['FrontResource'] != null
        ? FrontResource.fromJson(json['FrontResource'])
        : null;
    if (json['PropertyData'] != null) {
      propertyData = <PropertyData>[];
      json['PropertyData'].forEach((v) {
        propertyData!.add(PropertyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (frontLayout != null) {
      data['FrontLayout'] = frontLayout!.toJson();
    }
    if (frontResource != null) {
      data['FrontResource'] = frontResource!.toJson();
    }
    if (propertyData != null) {
      data['PropertyData'] = propertyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FrontLayout {
  int? memberFeature;
  int? eCouponFeature;
  int? favTextTap;
  int? favImageTap;
  int? retailTap;
  int? menuGroupTap;
  int? searchTap;
  int? promotionTap;
  int? paymentTap;

  FrontLayout(
      {this.memberFeature,
      this.eCouponFeature,
      this.favTextTap,
      this.favImageTap,
      this.retailTap,
      this.menuGroupTap,
      this.searchTap,
      this.promotionTap,
      this.paymentTap});

  FrontLayout.fromJson(Map<String, dynamic> json) {
    memberFeature = json['MemberFeature'];
    eCouponFeature = json['eCouponFeature'];
    favTextTap = json['FavTextTap'];
    favImageTap = json['FavImageTap'];
    retailTap = json['RetailTap'];
    menuGroupTap = json['MenuGroupTap'];
    searchTap = json['SearchTap'];
    promotionTap = json['PromotionTap'];
    paymentTap = json['PaymentTap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberFeature'] = memberFeature;
    data['eCouponFeature'] = eCouponFeature;
    data['FavTextTap'] = favTextTap;
    data['FavImageTap'] = favImageTap;
    data['RetailTap'] = retailTap;
    data['MenuGroupTap'] = menuGroupTap;
    data['SearchTap'] = searchTap;
    data['PromotionTap'] = promotionTap;
    data['PaymentTap'] = paymentTap;
    return data;
  }
}

class FrontResource {
  String? logoImage;
  String? loginImage;

  FrontResource({this.logoImage, this.loginImage});

  FrontResource.fromJson(Map<String, dynamic> json) {
    logoImage = json['LogoImage'];
    loginImage = json['LoginImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LogoImage'] = logoImage;
    data['LoginImage'] = loginImage;
    return data;
  }
}

class PropertyData {
  int? propertyID;
  String? propertyName;
  int? propertyValue;
  String? propertyDesp;
  List<PropertyParam>? propertyParam;

  PropertyData(
      {this.propertyID,
      this.propertyName,
      this.propertyValue,
      this.propertyDesp,
      this.propertyParam});

  PropertyData.fromJson(Map<String, dynamic> json) {
    propertyID = json['PropertyID'];
    propertyName = json['PropertyName'];
    propertyValue = json['PropertyValue'];
    propertyDesp = json['PropertyDesp'];
    if (json['PropertyParam'] != null) {
      propertyParam = <PropertyParam>[];
      json['PropertyParam'].forEach((v) {
        propertyParam!.add(PropertyParam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PropertyID'] = propertyID;
    data['PropertyName'] = propertyName;
    data['PropertyValue'] = propertyValue;
    data['PropertyDesp'] = propertyDesp;
    if (propertyParam != null) {
      data['PropertyParam'] = propertyParam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyParam {
  String? propertyName;
  String? propertyValue;
  String? desp;

  PropertyParam({this.propertyName, this.propertyValue, this.desp});

  PropertyParam.fromJson(Map<String, dynamic> json) {
    propertyName = json['PropertyName'];
    propertyValue = json['PropertyValue'];
    desp = json['Desp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PropertyName'] = propertyName;
    data['PropertyValue'] = propertyValue;
    data['Desp'] = desp;
    return data;
  }
}

class ReasonGroup {
  int? iD;
  String? name;

  ReasonGroup({this.iD, this.name});

  ReasonGroup.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    return data;
  }
}
