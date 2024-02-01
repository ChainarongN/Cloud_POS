import 'dart:convert';
import 'dart:io';
import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _loginRepository;
  LoginProvider(this._loginRepository);
  ApiState apisState = ApiState.COMPLETED;
  AuthTokenModel? authTokenModel;
  CoreInitModel? coreInitModel;
  LoginModel? loginModel;
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
      apisState = ApiState.ERROR;
    } else {
      authTokenModel = AuthTokenModel.fromJson(jsonDecode(response));
      await SharedPref().setToken(authTokenModel!.accessToken!);
      await login();
    }

    notifyListeners();
  }

  Future login() async {
    var response = await _loginRepository.login(
        username: 'cpos',
        password: 'cpos',
        deviceKey: '0288-7363-6560-2714',
        langId: '1');

    if (response is Failure) {
      Constants().printError(response.code.toString());
      Constants().printError(response.errorResponse.toString());
      _errorText = 'Invalid username or password';
      apisState = ApiState.ERROR;
    } else {
      loginModel = LoginModel.fromJson(jsonDecode(response));
      if (loginModel!.responseCode == '99') {
        if (loginModel!.responseText == Constants.INVALID_LOGIN) {
          _errorText = 'Invalid username or password';
        } else {
          String uuid = const Uuid().v4();
          await SharedPref().setUuid(uuid);
          await getCoreDataInit(true);
        }
      } else {
        await checkReadCoreData();
        apisState = ApiState.COMPLETED;
        _errorText = '';
      }
    }
  }

  Future checkReadCoreData() async {
    bool statusCoreData = await SharedPref().getNewDataSwitch();
    if (statusCoreData) {
      await getCoreDataInit(false);
    } else {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/${Constants.SALE_MODE_TXT}');
      bool fileExists = file.existsSync();
      if (!fileExists) {
        await getCoreDataInit(false);
      }
    }
  }

  Future getCoreDataInit(bool loginAgain) async {
    var response = await _loginRepository.getCoreDataDetail(
      deviceKey: '0288-7363-6560-2714',
      langID: '1',
    );
    if (response is Failure) {
      apisState = ApiState.ERROR;
      Constants().printError(response.code.toString());
      Constants().printError(response.errorResponse.toString());
    } else {
      try {
        coreInitModel = CoreInitModel.fromJson(jsonDecode(response));
        await Future.wait(
          [
            _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.saleModeData),
                Constants.SALE_MODE_TXT),
            _writeCoreInit(
                jsonEncode(
                    coreInitModel!.responseObj!.productData!.productGroup),
                Constants.PROD_GROUP_TXT),
            _writeCoreInit(
                jsonEncode(coreInitModel!.responseObj!.productData!.products),
                Constants.PROD_TXT),
            _writeCoreInit(
                jsonEncode(coreInitModel!.responseObj!.favoriteGroup),
                Constants.FAV_GROUP_TXT),
            _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.favoriteData),
                Constants.FAV_DATA_TXT)
          ],
        );

        Constants().printInfo(response.toString());
        Constants().printWarning('CoreDataInit');
        if (loginAgain) {
          await login();
        }
      } catch (e, strack) {
        apisState = ApiState.ERROR;
        _errorText = e.toString();
        Constants().printError(e.toString());
        Constants().printError(strack.toString());
      }
    }
    notifyListeners();
  }

  Future _writeCoreInit(String text, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(text);
  }

  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
