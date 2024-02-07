import 'dart:convert';
import 'dart:io';
import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/models/open_session_model.dart';
import 'package:cloud_pos/models/start_process_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _loginRepository;
  LoginProvider(this._loginRepository);
  ApiState apisState = ApiState.COMPLETED;
  AuthTokenModel? authTokenModel;
  CoreInitModel? coreInitModel;
  StartProcessModel? startProcessModel;
  OpenSessionModel? openSessionModel;
  LoginModel? loginModel;
  bool _passwordVisible = false;
  bool _openSession = false;
  String? _errorText = '';
  final TextEditingController _openAmountController = TextEditingController();

  String get getErrorText => _errorText!;
  bool get passwordVisible => _passwordVisible;
  bool get getOpenSession => _openSession;
  List<String> get getLanguageList => _languageList;
  TextEditingController get getOpenAmountController => _openAmountController;

  init() {
    _errorText = '';
  }

  Future flowOpen() async {
    _errorText = '';
    _openSession = false;
    apisState = ApiState.LOADING;
    await authToken();
    await login();
    await startProcess();
    apisState = ApiState.COMPLETED;

    String uuid = await SharedPref().getUuid();
    Constants().printWarning(uuid);
    notifyListeners();
  }

  Future startProcess() async {
    var response = await _loginRepository.startProcess(
        deviceId: '0288-7363-6560-2714', langID: '1');
    if (response is Failure) {
      Constants().printError(response.code.toString());
      _errorText = response.errorResponse.toString();
      apisState = ApiState.ERROR;
    } else {
      startProcessModel = StartProcessModel.fromJson(jsonDecode(response));
      await SharedPref()
          .setComputerID(startProcessModel!.responseObj!.computerID!);
      await SharedPref().setShopID(startProcessModel!.responseObj!.shopID!);
      await SharedPref().setSaleDate(startProcessModel!.responseObj!.saleDate!);

      Constants().printInfo(response);
      Constants().printWarning('startProcess');
      if (startProcessModel!.responseObj!.actionInfo!.actionCode != null) {
        _openSession = true;
      }
    }
  }

  Future openSession() async {
    apisState = ApiState.LOADING;
    try {
      var response = await _loginRepository.openSession(
          deviceId: '0288-7363-6560-2714',
          langID: '1',
          openAmount: _openAmountController.text);
      if (response is Failure) {
        Constants().printError(response.code.toString());
        _errorText = response.errorResponse.toString();
        apisState = ApiState.ERROR;
      } else {
        openSessionModel = OpenSessionModel.fromJson(jsonDecode(response));
        await SharedPref().setSessionKey(openSessionModel!.responseObj!.key!);

        apisState = ApiState.COMPLETED;
        Constants().printInfo(response);
        Constants().printWarning('openSession');
      }
    } catch (e, strack) {
      _errorText = strack.toString();
      apisState = ApiState.ERROR;
    }
  }

  Future authToken() async {
    DateTime now = DateTime.now();
    String openTokenDay = await SharedPref().getOpenTokenDay();
    if (openTokenDay.isEmpty || openTokenDay != now.day.toString()) {
      var response = await _loginRepository.authToken(
          clientID: 'verticaltec.cloudinventory.dev',
          grantType: 'client_credentials',
          clientSecret: 'acf7e10c71296430');
      if (response is Failure) {
        Constants().printError(response.code.toString());
        _errorText = response.errorResponse.toString();
        apisState = ApiState.ERROR;
      } else {
        authTokenModel = AuthTokenModel.fromJson(jsonDecode(response));
        await SharedPref().setToken(authTokenModel!.accessToken!);
        await SharedPref().setOpenTokenDay(now.day.toString());

        Constants().printInfo(response);
        Constants().printWarning('auth token');
      }
    }
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
      _errorText = response.errorResponse.toString();
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
        Constants().printInfo(response.toString());
        Constants().printWarning('Success Login');
        await SharedPref()
            .setStaffID(loginModel!.responseObj!.staffInfo!.staffID!);
        await checkReadCoreData();
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
      final File file = File('${directory.path}/${Constants.REASON_GROUP_TXT}');
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
      Constants().printError(response.code.toString());
      Constants().printError(response.errorResponse.toString());
      apisState = ApiState.ERROR;
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
                Constants.FAV_DATA_TXT),
            _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.reasonGroup),
                Constants.REASON_GROUP_TXT)
          ],
        );

        Constants().printInfo(response.toString());
        Constants().printWarning('CoreDataInit');
        if (loginAgain) {
          await login();
        }
      } catch (e, strack) {
        _errorText = e.toString();
        Constants().printError(e.toString());
        Constants().printError(strack.toString());
        apisState = ApiState.ERROR;
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

  setLanguage(BuildContext context, String value) async {
    await context.setLocale(Locale(value.toLowerCase()));
    notifyListeners();
  }

  final List<String> _languageList = ['EN', 'TH'];
}
