class PayAmountModel {
  String? payType;
  String? payDetail;
  double? price;

  PayAmountModel({
    this.payType,
    this.payDetail,
    this.price,
  });

  @override
  String toString() {
    return '{"payType : $payType","payDetail : $payDetail","price : $price}';
  }
}
