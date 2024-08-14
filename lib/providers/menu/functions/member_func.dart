import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/mobile/widget/drawer/member.dart';
import 'package:cloud_pos/providers/menu/menu_provider.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';

class MemberFunc {
  MemberFunc._internal();
  static final MemberFunc _instance = MemberFunc._internal();
  factory MemberFunc() => _instance;

  Future showMemberDialog(BuildContext context, MenuProvider menuRead,
      MenuProvider menuWatch) async {
    DialogStyle().dialogLoadding(context);
    menuRead.orderSummary(context).then((value) {
      if (menuWatch.apiState == ApiState.COMPLETED) {
        Navigator.pop(context);
        if (menuWatch.transactionModel!.responseObj!.tranData!.memberID == 0) {
          if (menuWatch.propertyInfoData!.frontLayout!.memberFeature != 0 &&
              menuWatch.propertyInfoData!.frontLayout!.memberFeature != 1) {
            openOtherTestDialog(context, menuWatch, menuRead);
          } else {
            openNumberMemberDialog(context, menuWatch, menuRead);
          }
        } else {
          menuRead
              .memberData(context,
                  menuWatch.transactionModel!.responseObj!.memberMobile!)
              .then((value) {
            if (menuWatch.apiState == ApiState.COMPLETED) {
              Navigator.maybePop(context);
              showMemberDetail(context, menuWatch, menuRead, true);
            }
          });
        }
      }
    });
  }
}
