import 'package:flutter/material.dart';

abstract class IHomeRepository {
  Future openTransaction(BuildContext context,
      {String? langID, int? saleModeId, int? noCustomer});
  Future holdBillSearch(BuildContext context, {String? langID});
  Future unHoldBill(BuildContext context, {String? langID, String? orderId});
}
