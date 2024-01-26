import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _loginRepository;
  LoginProvider(this._loginRepository);

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
