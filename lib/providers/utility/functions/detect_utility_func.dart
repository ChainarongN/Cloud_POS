import 'dart:convert';

import 'package:cloud_pos/models/close_session_model.dart';
import 'package:cloud_pos/models/end_day_model.dart';
import 'package:cloud_pos/models/session_search_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/utility/utility_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectUtilityFunc {
  DetectUtilityFunc._internal();
  static final DetectUtilityFunc _instance = DetectUtilityFunc._internal();
  factory DetectUtilityFunc() => _instance;

  Future<CloseSessionModel> detectCloseSession(
      BuildContext context, var response) async {
    var utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
    CloseSessionModel? closeSessionModel;
    try {
      if (response is Failure) {
        utilityProvider.apiState = ApiState.ERROR;
        DialogStyle().dialogError(context,
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
          DialogStyle().dialogError(context,
              error: closeSessionModel.responseText!,
              isPopUntil: true,
              popToPage: '/utilityPage');
        }
      }
    } catch (e, strack) {
      utilityProvider.apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      await DialogStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/utilityPage');
    }
    return closeSessionModel!;
  }

  Future<EndDayModel> detectEndDay(BuildContext context, var response) async {
    var utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
    EndDayModel? endDayModel;
    try {
      if (response is Failure) {
        utilityProvider.apiState = ApiState.ERROR;
        DialogStyle().dialogError(context,
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
          DialogStyle().dialogError(context,
              error: endDayModel.responseText!,
              isPopUntil: true,
              popToPage: '/utilityPage');
        }
      }
    } catch (e, strack) {
      utilityProvider.apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      await DialogStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/utilityPage');
    }
    return endDayModel!;
  }

  Future<SessionSearch> detectSessionSearch(
      BuildContext context, var response) async {
    var utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
    SessionSearch? sessionSearchModel;
    try {
      if (response is Failure) {
        utilityProvider.apiState = ApiState.ERROR;
        DialogStyle().dialogError(context,
            error: response.errorResponse.toString(),
            isPopUntil: true,
            popToPage: '/utilityPage');
      } else {
        sessionSearchModel = SessionSearch.fromJson(jsonDecode(response));
        if (sessionSearchModel.responseCode!.isEmpty) {
          Constants().printCheckFlow(response, 'SessionSearch');
          utilityProvider.apiState = ApiState.COMPLETED;
        } else {
          utilityProvider.apiState = ApiState.ERROR;
          DialogStyle().dialogError(context,
              error: sessionSearchModel.responseText!,
              isPopUntil: true,
              popToPage: '/utilityPage');
        }
      }
    } catch (e, strack) {
      utilityProvider.apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      await DialogStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/utilityPage');
    }
    return sessionSearchModel!;
  }
}
