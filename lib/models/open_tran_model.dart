class OpenTranModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  ResponseObj2? responseObj2;
  var loyaltyObj;

  OpenTranModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  OpenTranModel.fromJson(Map<String, dynamic> json) {
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
  String? orderID;
  String? orderNumber;
  String? billHeader;
  int? noCustomer;
  String? customerName;
  String? customerMobile;
  String? orderTime;
  String? receiptNumber;
  String? memberCode;
  String? memberName;
  String? memberMobile;
  int? shopID;
  String? shopCode;
  String? shopName;
  var storeKey;
  var storeName;
  String? saleDate;
  int? saleModeID;
  String? saleModeName;
  double? vATPercent;
  String? vATCode;
  int? vATType;
  double? totalQty;
  double? retailAmount;
  double? totalDiscount;
  double? netSale;
  double? serviceCharge;
  double? deliveryFee;
  double? roundingBill;
  double? payAmount;
  double? dueAmount;
  double? vatable;
  double? transactionVAT;
  int? transactionStatus;
  int? tableID;
  String? tableName;
  int? tableStatus;
  int? openStaffID;
  String? openStaff;
  String? openTime;
  int? paidStaffID;
  String? paidStaff;
  String? paidTime;
  int? voidStaffID;
  String? voidStaff;
  String? voidReason;
  String? voidTime;
  List<OrderList>? orderList;
  List<PromoList>? promoList;
  List<PaymentList>? paymentList;
  int? deliveryAgentID;
  String? deliveryAgent;
  String? riderName;
  String? riderMobile;
  int? riderStatusID;
  String? riderStatusName;
  String? agentOrderId;
  String? agentOrderRef;
  var deliveryAddress;
  var pickupStoreInfo;
  TranData? tranData;
  var paymentStatus;

  ResponseObj(
      {this.orderID,
      this.orderNumber,
      this.billHeader,
      this.noCustomer,
      this.customerName,
      this.customerMobile,
      this.orderTime,
      this.receiptNumber,
      this.memberCode,
      this.memberName,
      this.memberMobile,
      this.shopID,
      this.shopCode,
      this.shopName,
      this.storeKey,
      this.storeName,
      this.saleDate,
      this.saleModeID,
      this.saleModeName,
      this.vATPercent,
      this.vATCode,
      this.vATType,
      this.totalQty,
      this.retailAmount,
      this.totalDiscount,
      this.netSale,
      this.serviceCharge,
      this.deliveryFee,
      this.roundingBill,
      this.payAmount,
      this.dueAmount,
      this.vatable,
      this.transactionVAT,
      this.transactionStatus,
      this.tableID,
      this.tableName,
      this.tableStatus,
      this.openStaffID,
      this.openStaff,
      this.openTime,
      this.paidStaffID,
      this.paidStaff,
      this.paidTime,
      this.voidStaffID,
      this.voidStaff,
      this.voidReason,
      this.voidTime,
      this.orderList,
      this.paymentList,
      this.promoList,
      this.deliveryAgentID,
      this.deliveryAgent,
      this.riderName,
      this.riderMobile,
      this.riderStatusID,
      this.riderStatusName,
      this.agentOrderId,
      this.agentOrderRef,
      this.deliveryAddress,
      this.pickupStoreInfo,
      this.tranData,
      this.paymentStatus});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    orderNumber = json['OrderNumber'];
    billHeader = json['BillHeader'];
    noCustomer = json['NoCustomer'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    orderTime = json['OrderTime'];
    receiptNumber = json['ReceiptNumber'];
    memberCode = json['MemberCode'];
    memberName = json['MemberName'];
    memberMobile = json['MemberMobile'];
    shopID = json['ShopID'];
    shopCode = json['ShopCode'];
    shopName = json['ShopName'];
    storeKey = json['StoreKey'];
    storeName = json['StoreName'];
    saleDate = json['SaleDate'];
    saleModeID = json['SaleModeID'];
    saleModeName = json['SaleModeName'];
    vATPercent = json['VATPercent'];
    vATCode = json['VATCode'];
    vATType = json['VATType'];
    totalQty = json['TotalQty'];
    retailAmount = json['RetailAmount'];
    totalDiscount = json['TotalDiscount'];
    netSale = json['NetSale'];
    serviceCharge = json['ServiceCharge'];
    deliveryFee = json['DeliveryFee'];
    roundingBill = json['RoundingBill'];
    payAmount = json['PayAmount'];
    dueAmount = json['DueAmount'];
    vatable = json['Vatable'];
    transactionVAT = json['TransactionVAT'];
    transactionStatus = json['TransactionStatus'];
    tableID = json['TableID'];
    tableName = json['TableName'];
    tableStatus = json['TableStatus'];
    openStaffID = json['OpenStaffID'];
    openStaff = json['OpenStaff'];
    openTime = json['OpenTime'];
    paidStaffID = json['PaidStaffID'];
    paidStaff = json['PaidStaff'];
    paidTime = json['PaidTime'];
    voidStaffID = json['VoidStaffID'];
    voidStaff = json['VoidStaff'];
    voidReason = json['VoidReason'];
    voidTime = json['VoidTime'];
    if (json['OrderList'] != null) {
      orderList = <OrderList>[];
      json['OrderList'].forEach((v) {
        orderList!.add(OrderList.fromJson(v));
      });
    }
    if (json['PromoList'] != null) {
      promoList = <PromoList>[];
      json['PromoList'].forEach((v) {
        promoList!.add(PromoList.fromJson(v));
      });
    }
    if (json['PaymentList'] != null) {
      paymentList = <PaymentList>[];
      json['PaymentList'].forEach((v) {
        paymentList!.add(PaymentList.fromJson(v));
      });
    }
    deliveryAgentID = json['DeliveryAgentID'];
    deliveryAgent = json['DeliveryAgent'];
    riderName = json['RiderName'];
    riderMobile = json['RiderMobile'];
    riderStatusID = json['RiderStatusID'];
    riderStatusName = json['RiderStatusName'];
    agentOrderId = json['AgentOrderId'];
    agentOrderRef = json['AgentOrderRef'];
    deliveryAddress = json['DeliveryAddress'];
    pickupStoreInfo = json['PickupStoreInfo'];
    tranData =
        json['TranData'] != null ? TranData.fromJson(json['TranData']) : null;
    paymentStatus = json['PaymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderID'] = orderID;
    data['OrderNumber'] = orderNumber;
    data['BillHeader'] = billHeader;
    data['NoCustomer'] = noCustomer;
    data['CustomerName'] = customerName;
    data['CustomerMobile'] = customerMobile;
    data['OrderTime'] = orderTime;
    data['ReceiptNumber'] = receiptNumber;
    data['MemberCode'] = memberCode;
    data['MemberName'] = memberName;
    data['MemberMobile'] = memberMobile;
    data['ShopID'] = shopID;
    data['ShopCode'] = shopCode;
    data['ShopName'] = shopName;
    data['StoreKey'] = storeKey;
    data['StoreName'] = storeName;
    data['SaleDate'] = saleDate;
    data['SaleModeID'] = saleModeID;
    data['SaleModeName'] = saleModeName;
    data['VATPercent'] = vATPercent;
    data['VATCode'] = vATCode;
    data['VATType'] = vATType;
    data['TotalQty'] = totalQty;
    data['RetailAmount'] = retailAmount;
    data['TotalDiscount'] = totalDiscount;
    data['NetSale'] = netSale;
    data['ServiceCharge'] = serviceCharge;
    data['DeliveryFee'] = deliveryFee;
    data['RoundingBill'] = roundingBill;
    data['PayAmount'] = payAmount;
    data['DueAmount'] = dueAmount;
    data['Vatable'] = vatable;
    data['TransactionVAT'] = transactionVAT;
    data['TransactionStatus'] = transactionStatus;
    data['TableID'] = tableID;
    data['TableName'] = tableName;
    data['TableStatus'] = tableStatus;
    data['OpenStaffID'] = openStaffID;
    data['OpenStaff'] = openStaff;
    data['OpenTime'] = openTime;
    data['PaidStaffID'] = paidStaffID;
    data['PaidStaff'] = paidStaff;
    data['PaidTime'] = paidTime;
    data['VoidStaffID'] = voidStaffID;
    data['VoidStaff'] = voidStaff;
    data['VoidReason'] = voidReason;
    data['VoidTime'] = voidTime;
    if (orderList != null) {
      data['OrderList'] = orderList!.map((v) => v.toJson()).toList();
    }
    if (promoList != null) {
      data['PromoList'] = promoList!.map((v) => v.toJson()).toList();
    }
    if (paymentList != null) {
      data['PaymentList'] = paymentList!.map((v) => v.toJson()).toList();
    }
    data['DeliveryAgentID'] = deliveryAgentID;
    data['DeliveryAgent'] = deliveryAgent;
    data['RiderName'] = riderName;
    data['RiderMobile'] = riderMobile;
    data['RiderStatusID'] = riderStatusID;
    data['RiderStatusName'] = riderStatusName;
    data['AgentOrderId'] = agentOrderId;
    data['AgentOrderRef'] = agentOrderRef;
    data['DeliveryAddress'] = deliveryAddress;
    data['PickupStoreInfo'] = pickupStoreInfo;
    if (tranData != null) {
      data['TranData'] = tranData!.toJson();
    }
    data['PaymentStatus'] = paymentStatus;
    return data;
  }
}

class OrderList {
  int? orderDetailID;
  int? productID;
  String? itemNo;
  String? itemCode;
  String? itemName;
  double? unitPrice;
  double? qty;
  double? retailPrice;
  String? vATCode;
  int? statusID;
  int? pProductID;
  List<PromoItemList>? promoItemList;

  OrderList(
      {this.orderDetailID,
      this.productID,
      this.itemNo,
      this.itemCode,
      this.itemName,
      this.unitPrice,
      this.qty,
      this.retailPrice,
      this.vATCode,
      this.statusID,
      this.pProductID,
      this.promoItemList});

  OrderList.fromJson(Map<String, dynamic> json) {
    orderDetailID = json['OrderDetailID'];
    productID = json['ProductID'];
    itemNo = json['ItemNo'];
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    retailPrice = json['RetailPrice'];
    vATCode = json['VATCode'];
    statusID = json['StatusID'];
    pProductID = json['PProductID'];
    if (json['PromoItemList'] != null) {
      promoItemList = <PromoItemList>[];
      json['PromoItemList'].forEach((v) {
        promoItemList!.add(PromoItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderDetailID'] = orderDetailID;
    data['ProductID'] = productID;
    data['ItemNo'] = itemNo;
    data['ItemCode'] = itemCode;
    data['ItemName'] = itemName;
    data['UnitPrice'] = unitPrice;
    data['Qty'] = qty;
    data['RetailPrice'] = retailPrice;
    data['VATCode'] = vATCode;
    data['StatusID'] = statusID;
    data['PProductID'] = pProductID;
    if (promoItemList != null) {
      data['PromoItemList'] = promoItemList!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PromoList {
  int? promotionID;
  String? promotionCode;
  String? promotionName;
  String? remark;
  List<CouponList>? couponList;
  double? totalDiscount;

  PromoList(
      {this.promotionID,
      this.promotionCode,
      this.promotionName,
      this.remark,
      this.couponList,
      this.totalDiscount});

  PromoList.fromJson(Map<String, dynamic> json) {
    promotionID = json['PromotionID'];
    promotionCode = json['PromotionCode'];
    promotionName = json['PromotionName'];
    remark = json['Remark'];
    if (json['CouponList'] != null) {
      couponList = <CouponList>[];
      json['CouponList'].forEach((v) {
        couponList!.add(CouponList.fromJson(v));
      });
    }
    totalDiscount = json['TotalDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PromotionID'] = promotionID;
    data['PromotionCode'] = promotionCode;
    data['PromotionName'] = promotionName;
    data['Remark'] = remark;
    if (couponList != null) {
      data['CouponList'] = couponList!.map((v) => v.toJson()).toList();
    }
    data['TotalDiscount'] = totalDiscount;
    return data;
  }
}

class CouponList {
  String? promoUUID;
  String? couponNumber;
  double? discountAmount;

  CouponList({this.promoUUID, this.couponNumber, this.discountAmount});

  CouponList.fromJson(Map<String, dynamic> json) {
    promoUUID = json['PromoUUID'];
    couponNumber = json['CouponNumber'];
    discountAmount = json['DiscountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PromoUUID'] = promoUUID;
    data['CouponNumber'] = couponNumber;
    data['DiscountAmount'] = discountAmount;
    return data;
  }
}

class PromoItemList {
  int? promotionID;
  String? promotionCode;
  String? promotionName;
  double? totalDiscount;

  PromoItemList(
      {this.promotionID,
      this.promotionCode,
      this.promotionName,
      this.totalDiscount});

  PromoItemList.fromJson(Map<String, dynamic> json) {
    promotionID = json['PromotionID'];
    promotionCode = json['PromotionCode'];
    promotionName = json['PromotionName'];
    totalDiscount = json['TotalDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PromotionID'] = promotionID;
    data['PromotionCode'] = promotionCode;
    data['PromotionName'] = promotionName;
    data['TotalDiscount'] = totalDiscount;
    return data;
  }
}

class PaymentList {
  int? payDetailID;
  int? payTypeID;
  String? payTypeCode;
  String? payTypeName;
  String? remark;
  double? payAmount;
  double? cashChange;
  var payTypeImage;
  var payTypeDesp;

  PaymentList(
      {this.payDetailID,
      this.payTypeID,
      this.payTypeCode,
      this.payTypeName,
      this.remark,
      this.payAmount,
      this.cashChange,
      this.payTypeImage,
      this.payTypeDesp});

  PaymentList.fromJson(Map<String, dynamic> json) {
    payDetailID = json['PayDetailID'];
    payTypeID = json['PayTypeID'];
    payTypeCode = json['PayTypeCode'];
    payTypeName = json['PayTypeName'];
    remark = json['Remark'];
    payAmount = json['PayAmount'];
    cashChange = json['CashChange'];
    payTypeImage = json['PayTypeImage'];
    payTypeDesp = json['PayTypeDesp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PayDetailID'] = payDetailID;
    data['PayTypeID'] = payTypeID;
    data['PayTypeCode'] = payTypeCode;
    data['PayTypeName'] = payTypeName;
    data['Remark'] = remark;
    data['PayAmount'] = payAmount;
    data['CashChange'] = cashChange;
    data['PayTypeImage'] = payTypeImage;
    data['PayTypeDesp'] = payTypeDesp;
    return data;
  }
}

class TranData {
  String? orderID;
  int? transactionID;
  int? computerID;
  String? tranKey;
  int? saleMode;
  String? saleModeName;
  String? orderNumber;
  String? queueName;
  String? customerName;
  String? customerMobile;
  int? memberID;
  String? memberName;
  int? shopID;
  String? saleDate;
  double? receiptTotalQty;
  double? receiptPayPrice;
  double? dueAmount;
  int? assignStoreID;
  String? assignStoreKey;
  int? pickUpStoreID;
  String? pickUpStoreKey;
  String? pickUpDate;
  String? pickUpFromTime;
  String? pickUpToTime;
  int? decimalDigit;

  TranData(
      {this.orderID,
      this.transactionID,
      this.computerID,
      this.tranKey,
      this.saleMode,
      this.saleModeName,
      this.orderNumber,
      this.queueName,
      this.customerName,
      this.customerMobile,
      this.memberID,
      this.memberName,
      this.shopID,
      this.saleDate,
      this.receiptTotalQty,
      this.receiptPayPrice,
      this.dueAmount,
      this.assignStoreID,
      this.assignStoreKey,
      this.pickUpStoreID,
      this.pickUpStoreKey,
      this.pickUpDate,
      this.pickUpFromTime,
      this.pickUpToTime,
      this.decimalDigit});

  TranData.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    transactionID = json['TransactionID'];
    computerID = json['ComputerID'];
    tranKey = json['TranKey'];
    saleMode = json['SaleMode'];
    saleModeName = json['SaleModeName'];
    orderNumber = json['OrderNumber'];
    queueName = json['QueueName'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    memberID = json['MemberID'];
    memberName = json['MemberName'];
    shopID = json['ShopID'];
    saleDate = json['SaleDate'];
    receiptTotalQty = json['ReceiptTotalQty'];
    receiptPayPrice = json['ReceiptPayPrice'];
    dueAmount = json['DueAmount'];
    assignStoreID = json['AssignStoreID'];
    assignStoreKey = json['AssignStoreKey'];
    pickUpStoreID = json['PickUpStoreID'];
    pickUpStoreKey = json['PickUpStoreKey'];
    pickUpDate = json['PickUpDate'];
    pickUpFromTime = json['PickUpFromTime'];
    pickUpToTime = json['PickUpToTime'];
    decimalDigit = json['DecimalDigit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderID'] = orderID;
    data['TransactionID'] = transactionID;
    data['ComputerID'] = computerID;
    data['TranKey'] = tranKey;
    data['SaleMode'] = saleMode;
    data['SaleModeName'] = saleModeName;
    data['OrderNumber'] = orderNumber;
    data['QueueName'] = queueName;
    data['CustomerName'] = customerName;
    data['CustomerMobile'] = customerMobile;
    data['MemberID'] = memberID;
    data['MemberName'] = memberName;
    data['ShopID'] = shopID;
    data['SaleDate'] = saleDate;
    data['ReceiptTotalQty'] = receiptTotalQty;
    data['ReceiptPayPrice'] = receiptPayPrice;
    data['DueAmount'] = dueAmount;
    data['AssignStoreID'] = assignStoreID;
    data['AssignStoreKey'] = assignStoreKey;
    data['PickUpStoreID'] = pickUpStoreID;
    data['PickUpStoreKey'] = pickUpStoreKey;
    data['PickUpDate'] = pickUpDate;
    data['PickUpFromTime'] = pickUpFromTime;
    data['PickUpToTime'] = pickUpToTime;
    data['DecimalDigit'] = decimalDigit;
    return data;
  }
}

class ResponseObj2 {
  ReceiptInfo? receiptInfo;
  var printInfo;
  List<MoreInfo>? moreInfo;

  ResponseObj2({this.receiptInfo, this.printInfo, this.moreInfo});

  ResponseObj2.fromJson(Map<String, dynamic> json) {
    receiptInfo = json['ReceiptInfo'] != null
        ? ReceiptInfo.fromJson(json['ReceiptInfo'])
        : null;
    printInfo = json['PrintInfo'];
    if (json['MoreInfo'] != null) {
      moreInfo = <MoreInfo>[];
      json['MoreInfo'].forEach((v) {
        moreInfo!.add(MoreInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (receiptInfo != null) {
      data['ReceiptInfo'] = receiptInfo!.toJson();
    }
    data['PrintInfo'] = printInfo;
    if (moreInfo != null) {
      data['MoreInfo'] = moreInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceiptInfo {
  String? receiptHtml;
  String? receiptCopyHtml;
  int? noPrintCopy;

  ReceiptInfo({this.receiptHtml, this.receiptCopyHtml, this.noPrintCopy});

  ReceiptInfo.fromJson(Map<String, dynamic> json) {
    receiptHtml = json['ReceiptHtml'];
    receiptCopyHtml = json['ReceiptCopyHtml'];
    noPrintCopy = json['NoPrintCopy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReceiptHtml'] = receiptHtml;
    data['ReceiptCopyHtml'] = receiptCopyHtml;
    data['NoPrintCopy'] = noPrintCopy;
    return data;
  }
}

class MoreInfo {
  String? dataType;
  String? dataHtml;

  MoreInfo({this.dataType, this.dataHtml});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    dataType = json['DataType'];
    dataHtml = json['DataHtml'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DataType'] = dataType;
    data['DataHtml'] = dataHtml;
    return data;
  }
}
