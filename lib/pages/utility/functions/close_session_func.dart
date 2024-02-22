import 'dart:convert';
import 'package:cloud_pos/models/close_session_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/utility_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloseSessionFunc {
  CloseSessionFunc._internal();
  static final CloseSessionFunc _instance = CloseSessionFunc._internal();
  factory CloseSessionFunc() => _instance;

  Future<CloseSessionModel> detectCloseSession(
      BuildContext context, var response) async {
    var utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
    CloseSessionModel? closeSessionModel;
    try {
      if (response is Failure) {
        utilityProvider.apiState = ApiState.ERROR;
        LoadingStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/utilityPage');
      } else {
        closeSessionModel = CloseSessionModel.fromJson(jsonDecode(response));
        if (closeSessionModel.responseCode!.isEmpty) {
          Constants().printCheckFlow(response, 'closeSession');
          utilityProvider.apiState = ApiState.COMPLETED;
        } else {
          utilityProvider.apiState = ApiState.ERROR;
          LoadingStyle().dialogError(context,
              error: closeSessionModel.responseText!,
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
    return closeSessionModel!;
  }
}
