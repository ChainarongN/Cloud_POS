class PayAmountModel {
  String? payName;

  double? price;
  String? payCode;
  int? payTypeId;
  String? payRemark;

  PayAmountModel(
      {this.payName, this.price, this.payCode, this.payTypeId, this.payRemark});

  @override
  String toString() {
    return '{"payType : $payName","price : $price,"payCode": $payCode,"payTypeId": $payTypeId,"payRemail": $payRemark}';
  }
}
