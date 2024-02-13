import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io' show Platform;

class FirebaseLog {
  FirebaseLog._internal();
  static final FirebaseLog _instance = FirebaseLog._internal();
  factory FirebaseLog() => _instance;

  CollectionReference users = FirebaseFirestore.instance.collection('LogData');
  Future logData(bool isSuccess,
      {String? actionBy, String? reqData, String? res, String? params}) async {
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm:ss').format(now);
    String date = DateFormat.yMMMMd('en_US').format(now);
    String sessionKey = await SharedPref().getSessionKey();
    String reqId = await SharedPref().getUuid();
    int staffId = await SharedPref().getStaffID();
    int shopId = await SharedPref().getShopID();
    int computerId = await SharedPref().getComputerID();
    String orderId = await SharedPref().getOrderId();
    String username = await SharedPref().getUsername();
    String version = await SharedPref().getAppVersion();

    users
        .doc('Dev')
        .collection(date)
        .doc('User : $username')
        .collection(isSuccess ? 'isSuccess' : 'isError')
        .doc('Time $time')
        .set({
      "ActionBy": actionBy,
      "ReqId": reqId,
      "SessionKey": sessionKey,
      "App_platform": Platform.isAndroid ? "android" : "ios",
      "App_version": version,
      "Time": now,
      "ComputerId": computerId,
      "ShopId:": shopId,
      "StaffId": staffId,
      "OrderId": orderId,
      "res": res,
      "reqData": reqData ?? '',
      "reqParams": params
    });
  }
}
