import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageFav1Func {
  ManageFav1Func._internal();
  static final ManageFav1Func _instance = ManageFav1Func._internal();
  factory ManageFav1Func() => _instance;

  // changeIndexFav(
  //     BuildContext context, int oldIndex, int newIndex, int group) async {
  //   var menuPvd = Provider.of<MenuProvider>(context, listen: false);
  //   final item = menuPvd.favResultList!.removeAt(oldIndex);
  //   menuPvd.favResultList!.insert(newIndex, item);
  //   for (var i = 0; i < menuPvd.favResultList!.length; i++) {
  //     menuPvd.favResultList![i].buttonOrder = i + 1;
  //   }
  //   menuPvd.favoriteData!.removeWhere((element) => element.pageIndex == group);
  //   List<FavoriteData> result = menuPvd.favResultList!
  //       .where((element) => element.pageIndex == group)
  //       .toList();
  //   menuPvd.favoriteData!.addAll(result);
  // }

  showData(BuildContext context, int group) {
    var menuPvd = Provider.of<MenuProvider>(context, listen: false);
    int findMaxLength = 0;
    List<FavoriteData>? data = menuPvd.favoriteData!
        .where((element) => element.pageIndex == group)
        .toList();
    if (data.isNotEmpty) {
      for (var element in data) {
        if (element.buttonOrder! > findMaxLength) {
          findMaxLength = element.buttonOrder!;
        }
      }
      for (var i = 1; i < findMaxLength + 2; i++) {
        if (data.any((element) => element.buttonOrder == i)) {
          var result = data.where((element) => element.buttonOrder == i);
          menuPvd.favResultList!.add(FavoriteData(
            templateID: result.first.templateID,
            pageIndex: result.first.pageIndex,
            productCode: result.first.productCode,
            productID: result.first.productID,
            hexColor: result.first.hexColor,
            buttonOrder: result.first.buttonOrder,
          ));
        } else {
          menuPvd.favResultList!.add(FavoriteData(
            templateID: 0,
            pageIndex: 0,
            productCode: '',
            productID: 0,
            hexColor: '',
            buttonOrder: 0,
          ));
        }
      }
    }
  }
}
