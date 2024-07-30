// ignore_for_file: use_build_context_synchronously
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductFunc {
  AddProductFunc._internal();
  static final AddProductFunc _instance = AddProductFunc._internal();
  factory AddProductFunc() => _instance;

  Future addProductToList(BuildContext context,
      {int? prodId, double? count, String? orderDetailId}) async {
    var menuProvider = Provider.of<MenuProvider>(context, listen: false);

    // DialogStyle().commentDialog(context);
    await menuProvider.productObj(context, prodId!, orderDetailId!);
    if (menuProvider.apiState == ApiState.COMPLETED) {
      await menuProvider.productAdd(context, count!);
      if (menuProvider.apiState == ApiState.COMPLETED) {
        Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
      }
    }
  }
}
