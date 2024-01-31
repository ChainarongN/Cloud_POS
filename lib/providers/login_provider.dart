import 'dart:convert';
import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _loginRepository;
  LoginProvider(this._loginRepository);
  ApiState apisState = ApiState.COMPLETED;
  AuthTokenModel? authTokenModel;
  bool _passwordVisible = false;
  String? _errorText = '';

  String get getErrorText => _errorText!;
  bool get passwordVisible => _passwordVisible;

  init() {
    _errorText = '';
  }

  Future authToken() async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.authToken(
        clientID: 'verticaltec.cloudinventory.dev',
        grantType: 'client_credentials',
        clientSecret: 'acf7e10c71296430');

    if (response is Failure) {
      Constants().printError(response.code.toString());
      _errorText = 'Invalid username or password';
      apisState = ApiState.ERROR;
    } else {
      authTokenModel = AuthTokenModel.fromJson(jsonDecode(response));
      await SharedPref().setToken(authTokenModel!.accessToken!);
      apisState = ApiState.COMPLETED;
      Constants().printInfo(authTokenModel.toString());
      _errorText = '';
    }

    notifyListeners();
  }

  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
