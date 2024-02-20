class PayAmountModel {
  String? payName;
  String? payDetail;
  double? price;
  String? payCode;
  int? payTypeId;

  PayAmountModel({
    this.payName,
    this.payDetail,
    this.price,
    this.payCode,
    this.payTypeId,
  });

  @override
  String toString() {
    return '{"payType : $payName","payDetail : $payDetail","price : $price,"payCode": $payCode,"payTypeId": $payTypeId}';
  }
}
