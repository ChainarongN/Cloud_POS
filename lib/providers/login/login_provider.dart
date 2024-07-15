// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/models/open_session_model.dart';
import 'package:cloud_pos/models/start_process_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/home/home_provider.dart';
import 'package:cloud_pos/providers/login/functions/detect_login_func.dart';
import 'package:cloud_pos/providers/menu/functions/read_file_func.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
  String? _errorText = '', versionName = '';
  List<SaleModeData>? saleModeDataList;
  ShopData? shopData;
  final TextEditingController openAmountController = TextEditingController();
  final TextEditingController deviceController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // --------------------------- GET ---------------------------
  String get getErrorText => _errorText!;
  bool get passwordVisible => _passwordVisible;
  bool get getOpenSession => _openSession;
  List<String> get getLanguageList => _languageList;
  Future<String> getBaseUrl() async {
    String result = await SharedPref().getBaseUrl();
    return result;
  }

  // ------------------------ Call Data -------------------------
  init() async {
    _errorText = '';
    deviceController.text = await SharedPref().getDeviceId();
    versionName = await SharedPref().getAppVersion();
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${Constants.SHOP_DATA_TXT}');
    bool fileExists = file.existsSync();
    if (fileExists) {
      _readShopData();
    }
    notifyListeners();
  }

  Future flowOpen(BuildContext context) async {
    _errorText = '';
    _openSession = false;
    apisState = ApiState.LOADING;
    await authToken(context);
    await login(context);
    if (apisState == ApiState.COMPLETED) {
      await startProcess(context);
      String uuid = await SharedPref().getUuid();
      Constants().printWarning(uuid);
    }
    notifyListeners();
  }

  Future startProcess(BuildContext context) async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.startProcess(langID: '1');
    startProcessModel =
        await DetectLoginFunc().detectStartProcess(context, response);
    if (apisState == ApiState.COMPLETED) {
      await SharedPref()
          .setComputerID(startProcessModel!.responseObj!.computerID!);
      await SharedPref().setShopID(startProcessModel!.responseObj!.shopID!);
      await SharedPref().setSaleDate(startProcessModel!.responseObj!.saleDate!);
      if (startProcessModel!.responseObj!.actionInfo!.actionCode != null) {
        _openSession = true;
      }
    }
  }

  Future openSession(BuildContext context) async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.openSession(
        langID: '1', openAmount: openAmountController.text);
    openSessionModel =
        await DetectLoginFunc().detectOpenSession(context, response);
    if (apisState == ApiState.COMPLETED) {
      await SharedPref().setSessionKey(openSessionModel!.responseObj!.key!);
    }
  }

  Future authToken(BuildContext context) async {
    apisState = ApiState.LOADING;
    DateTime now = DateTime.now();
    // String openTokenDay = await SharedPref().getOpenTokenDay();
    // if (openTokenDay.isEmpty || openTokenDay != now.day.toString()) {
    var response = await _loginRepository.authToken(
        clientID: 'verticaltec.cloudinventory.dev',
        grantType: 'client_credentials',
        clientSecret: 'acf7e10c71296430');
    authTokenModel = await DetectLoginFunc().detectAuthToken(context, response);
    if (apisState == ApiState.COMPLETED) {
      await SharedPref().setToken(authTokenModel!.accessToken!);
      await SharedPref().setOpenTokenDay(now.day.toString());
    }
    // }
  }

  Future login(BuildContext context) async {
    apisState = ApiState.LOADING;
    // String username = 'cpos';
    // String password = 'cpos';
    var response = await _loginRepository.login(
      username: usernameController.text,
      password: passwordController.text,
      langId: '1',
    );
    loginModel = await DetectLoginFunc().detectLogin(context, response);
    if (apisState == ApiState.COMPLETED) {
      if (loginModel!.responseCode == '99') {
        if (loginModel!.responseText == Constants.INVALID_LOGIN) {
          _errorText = 'Invalid username or password';
          DialogStyle().dialogError(context,
              error: _errorText, isPopUntil: true, popToPage: '/loginPage');
          apisState = ApiState.ERROR;
        } else {
          await getCoreDataInit(context, true);
        }
      } else {
        Constants().printCheckFlow(response, 'Success Login');
        await SharedPref()
            .setStaffID(loginModel!.responseObj!.staffInfo!.staffID!);
        await SharedPref().setUsername(usernameController.text);
        await SharedPref()
            .setStaffCode(loginModel!.responseObj!.staffInfo!.staffCode!);
        await SharedPref().setStaffRoleName(
            loginModel!.responseObj!.staffInfo!.staffRoleName!);

        await checkReadCoreData(context);
        _errorText = '';
      }
    }
  }

  Future checkReadCoreData(BuildContext context) async {
    var homePvd = context.read<HomeProvider>();
    bool statusCoreData = await SharedPref().getNewDataSwitch();
    if (statusCoreData) {
      await getCoreDataInit(context, false);
    } else {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/${Constants.REASON_GROUP_TXT}');
      bool fileExists = file.existsSync();
      if (!fileExists) {
        await getCoreDataInit(context, false);
      }
      saleModeDataList = [];
      await readSaleModeFile();
      homePvd.setSaleModeData(saleModeDataList);
      _readShopData();
    }
    notifyListeners();
  }

  Future getCoreDataInit(BuildContext context, bool loginAgain) async {
    var homePvd = context.read<HomeProvider>();
    apisState = ApiState.LOADING;
    var response = await _loginRepository.getCoreDataDetail(
      langID: '1',
    );
    coreInitModel =
        await DetectLoginFunc().detectCoreDataInit(context, response);
    if (apisState == ApiState.COMPLETED) {
      await Future.wait(
        [
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.saleModeData),
              Constants.SALE_MODE_TXT),
          _writeCoreInit(
              jsonEncode(coreInitModel!.responseObj!.productData!.productGroup),
              Constants.PROD_GROUP_TXT),
          _writeCoreInit(
              jsonEncode(coreInitModel!.responseObj!.productData!.productDept),
              Constants.PROD_DEPT_TXT),
          _writeCoreInit(
              jsonEncode(coreInitModel!.responseObj!.productData!.products),
              Constants.PROD_TXT),
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.favoriteGroup),
              Constants.FAV_GROUP_TXT),
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.favoriteData),
              Constants.FAV_DATA_TXT),
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.reasonGroup),
              Constants.REASON_GROUP_TXT),
          _writeCoreInit(
              jsonEncode(coreInitModel!.responseObj!.payTypeData!.payTypeInfo),
              Constants.PAYMENT_GROUP_TXT),
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.shopData),
              Constants.SHOP_DATA_TXT),
          _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.computerName),
              Constants.COMPUTER_NAME_TXT),
          _writeCoreInit(
              jsonEncode(coreInitModel!.responseObj!.payTypeData!.currencyInfo),
              Constants.CURRENCY_INFO_TXT)
        ],
      );
      shopData = coreInitModel!.responseObj!.shopData;
      saleModeDataList = [];
      await readSaleModeFile();
      homePvd.setSaleModeData(saleModeDataList);
      if (loginAgain) {
        await login(context);
      }
    }
    notifyListeners();
  }

  Future _writeCoreInit(String text, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(text);
  }

  Future readSaleModeFile() async {
    try {
      String? fileResponse =
          await ReadFileFunc().readCoreInit(Constants.SALE_MODE_TXT);
      saleModeDataList = (jsonDecode(fileResponse) as List)
          .map((e) => SaleModeData.fromJson(e))
          .toList();
      Constants().printWarning('Read from file "${Constants.SALE_MODE_TXT}"');
      apisState = ApiState.COMPLETED;
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _errorText = e.toString();
      apisState = ApiState.ERROR;
    }
    notifyListeners();
  }

  Future _readShopData() async {
    var value = await ReadFileFunc().readShopData();
    shopData = value;
    notifyListeners();
  }

  // --------------------------- SET ---------------------------
  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  setLanguage(BuildContext context, String value) async {
    await context.setLocale(Locale(value.toLowerCase()));
    notifyListeners();
  }

  setTextError(String value) {
    _errorText = value;
    notifyListeners();
  }

  setMockDeviceId() {
    // deviceController.text = '0288-7363-6560-2714';
    deviceController.text = '0003-2331-5123-5071';

    notifyListeners();
  }

  setUsernameForTest() {
    // usernameController.text = 'cpos';
    // passwordController.text = 'cpos';
    usernameController.text = '1';
    passwordController.text = '1';
    notifyListeners();
  }

  final List<String> _languageList = ['EN', 'TH'];
}
