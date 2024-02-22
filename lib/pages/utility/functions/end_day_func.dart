import 'dart:convert';
import 'package:cloud_pos/models/end_day_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/utility_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndDayFunc {
  EndDayFunc._internal();
  static final EndDayFunc _instance = EndDayFunc._internal();
  factory EndDayFunc() => _instance;

  Future<EndDayModel> detectEndDay(BuildContext context, var response) async {
    var utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
    EndDayModel? endDayModel;
    try {
      if (response is Failure) {
        utilityProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/utilityPage');
      } else {
        endDayModel = EndDayModel.fromJson(jsonDecode(response));
        if (endDayModel.responseCode!.isEmpty) {
          utilityProvider.apiState = ApiState.COMPLETED;
          Constants().printCheckFlow(response, 'endDay');
        } else {
          utilityProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: endDayModel.responseText!,
              isPopUntil: true,
              popToPage: '/utilityPage');
        }
      }
    } catch (e, strack) {
      utilityProvider.apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      await LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/utilityPage');
    }
    return endDayModel!;
  }
}
