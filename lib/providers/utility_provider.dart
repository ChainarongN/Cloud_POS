// ignore_for_file: use_build_context_synchronously
import 'package:cloud_pos/models/close_session_model.dart';
import 'package:cloud_pos/models/end_day_model.dart';
import 'package:cloud_pos/models/session_search_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/utility/functions/detect_utility_func.dart';
import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:flutter/material.dart';

class UtilityProvider extends ChangeNotifier {
  final IUtilityRepository _utilityRepository;
  UtilityProvider(this._utilityRepository);

  ApiState apiState = ApiState.COMPLETED;
  CloseSessionModel? closeSessionModel;
  EndDayModel? endDayModel;
  SessionSearch? sessionSearchModel;
  String _errorText = '';
  final TextEditingController _closeAmountController = TextEditingController();
  String _htmlResult = '';

  // --------------------------- GET ---------------------------
  TextEditingController get getCloseAmountController => _closeAmountController;
  String get getErrorText => _errorText;
  String get getHtml => _htmlResult;

  // ------------------------ Call Data -------------------------
  Future endDay(BuildContext context) async {
    apiState = ApiState.LOADING;
    var res = await _utilityRepository.endDay(deviceKey: '0288-7363-6560-2714');
    endDayModel = await DetectUtilityFunc().detectEndDay(context, res);
    if (apiState == ApiState.COMPLETED) {
      _htmlResult = endDayModel!.responseObj!.printDataHtml!;
    }

    // apiState = ApiState.LOADING;
    // try {
    //   var response =
    //       await _utilityRepository.endDay(deviceKey: '0288-7363-6560-2714');
    //   if (response is Failure) {
    //     _errorText = response.errorResponse.toString();
    //     apiState = ApiState.ERROR;
    //   } else {
    //     endDayModel = EndDayModel.fromJson(jsonDecode(response));
    //     if (endDayModel!.responseCode!.isEmpty) {
    //       _htmlResult = endDayModel!.responseObj!.printDataHtml!;
    //       apiState = ApiState.COMPLETED;
    //       Constants().printCheckFlow(response, 'endDay');
    //     } else {
    //       _errorText = endDayModel!.responseText!;
    //       apiState = ApiState.ERROR;
    //     }
    //   }
    // } catch (e, strack) {
    //   apiState = ApiState.ERROR;
    //   _errorText = strack.toString();
    // }
  }

  Future closeSession(BuildContext context) async {
    String key = await SharedPref().getSessionKey();
    if (key.isEmpty) {
      await sessionSearch(context);
    } else {
      apiState = ApiState.LOADING;
      String key = await SharedPref().getSessionKey();
      int idx = key.indexOf(":");
      String sessionId = key.substring(0, idx).trim();
      var response = await _utilityRepository.closeSession(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          sessionId: sessionId,
          closeSSAmount: _closeAmountController.text);
      closeSessionModel =
          await DetectUtilityFunc().detectCloseSession(context, response);
      if (apiState == ApiState.COMPLETED) {
        _htmlResult = closeSessionModel!.responseObj!.printDataHtml!;
      }
    }
  }

  Future sessionSearch(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _utilityRepository.sessionSearch(
        langId: '1', deviceKey: '0288-7363-6560-2714');
    sessionSearchModel =
        await DetectUtilityFunc().detectSessionSearch(context, response);
    if (apiState == ApiState.COMPLETED) {
      await SharedPref()
          .setSessionKey(sessionSearchModel!.responseObj!.last.sessionKey!);
      await closeSession(context);
    }
  }

  // --------------------------- SET ---------------------------
  Future setCloseAmountController(String val) async {
    _closeAmountController.text = val;
    notifyListeners();
  }

  Future setExceptionText(String value) async {
    _errorText = value;
    notifyListeners();
  }
}
