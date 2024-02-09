import 'dart:convert';

import 'package:cloud_pos/models/close_session_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class UtilityProvider extends ChangeNotifier {
  final IUtilityRepository _utilityRepository;
  UtilityProvider(this._utilityRepository);

  ApiState apiState = ApiState.COMPLETED;
  CloseSessionModel? closeSessionModel;
  String _errorText = '';
  final TextEditingController _closeAmountController = TextEditingController();
  String _htmlCloseSession = '';

  TextEditingController get getCloseAmountController => _closeAmountController;
  String get getErrorText => _errorText;
  String get getHtmlCloseSession => _htmlCloseSession;

  Future closeSession() async {
    apiState = ApiState.COMPLETED;
    String key = await SharedPref().getSessionKey();
    int idx = key.indexOf(":");
    String sessionId = key.substring(0, idx).trim();
    try {
      var response = await _utilityRepository.closeSession(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          sessionId: sessionId,
          closeSSAmount: _closeAmountController.text);
      if (response is Failure) {
        Constants().printError(response.code.toString());
        _errorText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        _errorText = '';
      } else {
        closeSessionModel = CloseSessionModel.fromJson(jsonDecode(response));
        if (closeSessionModel!.responseCode!.isEmpty) {
          _htmlCloseSession = closeSessionModel!.responseObj!.printDataHtml!;
          apiState = ApiState.COMPLETED;
          Constants().printInfo(response);
          Constants().printWarning('closeSession');
        } else {
          _errorText = closeSessionModel!.responseText!;
          apiState = ApiState.ERROR;
        }
      }
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      _errorText = strack.toString();
    }
  }

  Future setCloseAmountController(String val) async {
    _closeAmountController.text = val;
    notifyListeners();
  }
}
