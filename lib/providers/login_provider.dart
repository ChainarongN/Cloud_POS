import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _loginRepository;
  LoginProvider(this._loginRepository);

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  init() {}

  Future<bool> authToken() async {
    var response = await _loginRepository.authToken(
        clientID: 'verticaltec.cloudinventory.dev',
        grantType: 'client_credentials',
        clientSecret: 'acf7e10c71296430');
    print(response);

    return true;
  }

  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
