class ProductObjModel {
  String? responseCode;
  String? responseText;
  var pendingReqId;
  ResponseObj? responseObj;
  var responseObj2;
  var loyaltyObj;

  ProductObjModel(
      {this.responseCode,
      this.responseText,
      this.pendingReqId,
      this.responseObj,
      this.responseObj2,
      this.loyaltyObj});

  ProductObjModel.fromJson(Map<String, dynamic> json) {
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
  TranData? tranData;
  ProductData? productData;
  ComboData? comboData;

  ResponseObj({this.tranData, this.productData, this.comboData});

  ResponseObj.fromJson(Map<String, dynamic> json) {
    tranData =
        json['TranData'] != null ? TranData.fromJson(json['TranData']) : null;
    productData = json['ProductData'] != null
        ? ProductData.fromJson(json['ProductData'])
        : null;
    comboData = json['ComboData'] != null
        ? ComboData.fromJson(json['ComboData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tranData != null) {
      data['TranData'] = tranData!.toJson();
    }
    if (productData != null) {
      data['ProductData'] = productData!.toJson();
    }
    if (comboData != null) {
      data['ComboData'] = comboData!.toJson();
    }

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

class ProductData {
  int? orderDetailID;
  int? productID;
  String? productCode;
  String? productName;
  String? productDesp;
  String? imageUrl;
  int? productTypeID;
  String? productTypeName;
  double? productQty;
  List<CommentGroup>? commentGroup;
  List<Comments>? comments;

  ProductData(
      {this.orderDetailID,
      this.productID,
      this.productCode,
      this.productName,
      this.productDesp,
      this.imageUrl,
      this.productTypeID,
      this.productTypeName,
      this.productQty,
      this.comments});

  ProductData.fromJson(Map<String, dynamic> json) {
    orderDetailID = json['OrderDetailID'];
    productID = json['ProductID'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    productDesp = json['ProductDesp'];
    imageUrl = json['ImageUrl'];
    productTypeID = json['ProductTypeID'];
    productTypeName = json['ProductTypeName'];
    productQty = json['ProductQty'];
    if (json['CommentGroup'] != null) {
      commentGroup = <CommentGroup>[];
      json['CommentGroup'].forEach((v) {
        commentGroup!.add(CommentGroup.fromJson(v));
      });
    }
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderDetailID'] = orderDetailID;
    data['ProductID'] = productID;
    data['ProductCode'] = productCode;
    data['ProductName'] = productName;
    data['ProductDesp'] = productDesp;
    data['ImageUrl'] = imageUrl;
    data['ProductTypeID'] = productTypeID;
    data['ProductTypeName'] = productTypeName;
    data['ProductQty'] = productQty;
    if (comments != null) {
      data['Comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentGroup {
  int? groupID;
  String? groupName;
  int? isMulti;

  CommentGroup({this.groupID, this.groupName, this.isMulti});

  CommentGroup.fromJson(Map<String, dynamic> json) {
    groupID = json['GroupID'];
    groupName = json['GroupName'];
    isMulti = json['IsMulti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupID'] = this.groupID;
    data['GroupName'] = this.groupName;
    data['IsMulti'] = this.isMulti;
    return data;
  }
}

class Comments {
  int? groupID;
  int? productID;
  double? commentPrice;
  String? productCode;
  String? productName;
  String? productDesp;
  double? requireQty;
  double? qty;
  double? pricePerUnit;
  String? commentText;

  Comments(
      {this.groupID,
      this.productID,
      this.commentPrice,
      this.productCode,
      this.productName,
      this.productDesp,
      this.requireQty,
      this.qty,
      this.pricePerUnit,
      this.commentText});

  Comments.fromJson(Map<String, dynamic> json) {
    groupID = json['GroupID'];
    productID = json['ProductID'];
    commentPrice = json['CommentPrice'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    productDesp = json['ProductDesp'];
    requireQty = json['RequireQty'];
    qty = json['Qty'];
    pricePerUnit = json['PricePerUnit'];
    commentText = json['CommentText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GroupID'] = groupID;
    data['ProductID'] = productID;
    data['CommentPrice'] = commentPrice;
    data['ProductCode'] = productCode;
    data['ProductName'] = productName;
    data['ProductDesp'] = productDesp;
    data['RequireQty'] = requireQty;
    data['Qty'] = qty;
    data['PricePerUnit'] = pricePerUnit;
    data['CommentText'] = commentText;
    return data;
  }
}

class ComboData {
  int? orderDetailID;
  int? productParentID;
  String? productParentCode;
  String? productParentName;
  String? productParentDesp;
  String? imageUrl;
  int? productTypeID;
  String? productTypeName;
  double? productQty;
  List<CommentGroup>? commentGroup;
  List<Group>? group;

  ComboData(
      {this.orderDetailID,
      this.productParentID,
      this.productParentCode,
      this.productParentName,
      this.productParentDesp,
      this.imageUrl,
      this.productTypeID,
      this.productTypeName,
      this.productQty,
      this.commentGroup,
      this.group});

  ComboData.fromJson(Map<String, dynamic> json) {
    orderDetailID = json['OrderDetailID'];
    productParentID = json['ProductParentID'];
    productParentCode = json['ProductParentCode'];
    productParentName = json['ProductParentName'];
    productParentDesp = json['ProductParentDesp'];
    imageUrl = json['ImageUrl'];
    productTypeID = json['ProductTypeID'];
    productTypeName = json['ProductTypeName'];
    productQty = json['ProductQty'];
    if (json['CommentGroup'] != null) {
      commentGroup = <CommentGroup>[];
      json['CommentGroup'].forEach((v) {
        commentGroup!.add(new CommentGroup.fromJson(v));
      });
    }
    if (json['Group'] != null) {
      group = <Group>[];
      json['Group'].forEach((v) {
        group!.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderDetailID'] = this.orderDetailID;
    data['ProductParentID'] = this.productParentID;
    data['ProductParentCode'] = this.productParentCode;
    data['ProductParentName'] = this.productParentName;
    data['ProductParentDesp'] = this.productParentDesp;
    data['ImageUrl'] = this.imageUrl;
    data['ProductTypeID'] = this.productTypeID;
    data['ProductTypeName'] = this.productTypeName;
    data['ProductQty'] = this.productQty;
    if (this.commentGroup != null) {
      data['CommentGroup'] = this.commentGroup!.map((v) => v.toJson()).toList();
    }
    if (this.group != null) {
      data['Group'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  int? groupID;
  int? groupNo;
  String? groupName;
  String? groupDesp;
  double? minQty;
  double? maxQty;
  double? requireQty;
  List<ItemList>? itemList;

  Group(
      {this.groupID,
      this.groupNo,
      this.groupName,
      this.groupDesp,
      this.minQty,
      this.maxQty,
      this.requireQty,
      this.itemList});

  Group.fromJson(Map<String, dynamic> json) {
    groupID = json['GroupID'];
    groupNo = json['GroupNo'];
    groupName = json['GroupName'];
    groupDesp = json['GroupDesp'];
    minQty = json['MinQty'];
    maxQty = json['MaxQty'];
    requireQty = json['RequireQty'];
    if (json['ItemList'] != null) {
      itemList = <ItemList>[];
      json['ItemList'].forEach((v) {
        itemList!.add(new ItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupID'] = this.groupID;
    data['GroupNo'] = this.groupNo;
    data['GroupName'] = this.groupName;
    data['GroupDesp'] = this.groupDesp;
    data['MinQty'] = this.minQty;
    data['MaxQty'] = this.maxQty;
    data['RequireQty'] = this.requireQty;
    if (this.itemList != null) {
      data['ItemList'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  int? productID;
  String? productCode;
  String? productName;
  String? productDesp;
  String? imageUrl;
  double? qty;
  double? qtyRatio;
  double? qtyValue;
  double? addPrice;
  List<Comments>? comments;

  ItemList(
      {this.productID,
      this.productCode,
      this.productName,
      this.productDesp,
      this.imageUrl,
      this.qty,
      this.qtyRatio,
      this.qtyValue,
      this.addPrice,
      this.comments});

  ItemList.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    productDesp = json['ProductDesp'];
    imageUrl = json['ImageUrl'];
    qty = json['Qty'];
    qtyRatio = json['QtyRatio'];
    qtyValue = json['QtyValue'];
    addPrice = json['AddPrice'];
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductID'] = this.productID;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['ProductDesp'] = this.productDesp;
    data['ImageUrl'] = this.imageUrl;
    data['Qty'] = this.qty;
    data['QtyRatio'] = this.qtyRatio;
    data['QtyValue'] = this.qtyValue;
    data['AddPrice'] = this.addPrice;
    if (this.comments != null) {
      data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
