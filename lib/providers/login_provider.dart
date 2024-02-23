// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloud_pos/models/auth_token_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/login_model.dart';
import 'package:cloud_pos/models/open_session_model.dart';
import 'package:cloud_pos/models/start_process_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/login/functions/detect_login_func.dart';
import 'package:cloud_pos/repositorys/login/i_login_repository.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

  // --------------------------- GET ---------------------------
  String get getErrorText => _errorText!;
  bool get passwordVisible => _passwordVisible;
  bool get getOpenSession => _openSession;
  List<String> get getLanguageList => _languageList;
  TextEditingController get getOpenAmountController => _openAmountController;

  // ------------------------ Call Data -------------------------
  init() {
    _errorText = '';
  }

  Future flowOpen(BuildContext context) async {
    _errorText = '';
    _openSession = false;
    apisState = ApiState.LOADING;
    await authToken(context);
    await login(context);
    await startProcess(context);

    String uuid = await SharedPref().getUuid();
    Constants().printWarning(uuid);
    notifyListeners();
  }

  Future startProcess(BuildContext context) async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.startProcess(
        deviceId: '0288-7363-6560-2714', langID: '1');
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

    // if (response is Failure) {
    //   Constants().printError(response.code.toString());
    //   _errorText = response.errorResponse.toString();
    //   apisState = ApiState.ERROR;
    // } else {
    //   startProcessModel = StartProcessModel.fromJson(jsonDecode(response));
    //   await SharedPref()
    //       .setComputerID(startProcessModel!.responseObj!.computerID!);
    //   await SharedPref().setShopID(startProcessModel!.responseObj!.shopID!);
    //   await SharedPref().setSaleDate(startProcessModel!.responseObj!.saleDate!);
    //   Constants().printCheckFlow(response, 'startProcess');
    //   if (startProcessModel!.responseObj!.actionInfo!.actionCode != null) {
    //     _openSession = true;
    //   }
    // }
  }

  Future openSession(BuildContext context) async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.openSession(
        deviceId: '0288-7363-6560-2714',
        langID: '1',
        openAmount: _openAmountController.text);
    openSessionModel =
        await DetectLoginFunc().detectOpenSession(context, response);
    if (apisState == ApiState.COMPLETED) {
      await SharedPref().setSessionKey(openSessionModel!.responseObj!.key!);
    }

    //  try {
//       if (response is Failure) {
//         Constants().printError(response.code.toString());
//         _errorText = response.errorResponse.toString();
//         apisState = ApiState.ERROR;
//       } else {
//         openSessionModel = OpenSessionModel.fromJson(jsonDecode(response));
//         await SharedPref().setSessionKey(openSessionModel!.responseObj!.key!);
//
//         apisState = ApiState.COMPLETED;
//         Constants().printCheckFlow(response, 'openSession');
//       }
//     } catch (e, strack) {
//       _errorText = strack.toString();
//       Constants().printError('$e - $strack');
//       apisState = ApiState.ERROR;
//     }
  }

  Future authToken(BuildContext context) async {
    apisState = ApiState.LOADING;
    DateTime now = DateTime.now();
    String openTokenDay = await SharedPref().getOpenTokenDay();
    if (openTokenDay.isEmpty || openTokenDay != now.day.toString()) {
      var response = await _loginRepository.authToken(
          clientID: 'verticaltec.cloudinventory.dev',
          grantType: 'client_credentials',
          clientSecret: 'acf7e10c71296430');
      authTokenModel =
          await DetectLoginFunc().detectAuthToken(context, response);
      if (apisState == ApiState.COMPLETED) {
        await SharedPref().setToken(authTokenModel!.accessToken!);
        await SharedPref().setOpenTokenDay(now.day.toString());
      }
    }
  }

  Future login(BuildContext context) async {
    apisState = ApiState.LOADING;
    String username = 'cpos';
    var response = await _loginRepository.login(
        username: username,
        password: 'cpos',
        deviceKey: '0288-7363-6560-2714',
        langId: '1');
    loginModel = await DetectLoginFunc().detectLogin(context, response);
    if (apisState == ApiState.COMPLETED) {
      if (loginModel!.responseCode == '99') {
        if (loginModel!.responseText == Constants.INVALID_LOGIN) {
          _errorText = 'Invalid username or password';
        } else {
          await getCoreDataInit(context, true);
        }
      } else {
        Constants().printCheckFlow(response, 'Success Login');
        await SharedPref()
            .setStaffID(loginModel!.responseObj!.staffInfo!.staffID!);
        await SharedPref().setUsername(username);
        await checkReadCoreData(context);
        _errorText = '';
      }
    }

    // if (response is Failure) {
    //   Constants().printError(response.code.toString());
    //   Constants().printError(response.errorResponse.toString());
    //   _errorText = response.errorResponse.toString();
    //   apisState = ApiState.ERROR;
    // } else {
    //   loginModel = LoginModel.fromJson(jsonDecode(response));
    //   if (loginModel!.responseCode == '99') {
    //     if (loginModel!.responseText == Constants.INVALID_LOGIN) {
    //       _errorText = 'Invalid username or password';
    //     } else {
    //       await getCoreDataInit(true);
    //     }
    //   } else {
    //     Constants().printCheckFlow(response, 'Success Login');
    //     await SharedPref()
    //         .setStaffID(loginModel!.responseObj!.staffInfo!.staffID!);
    //     await SharedPref().setUsername(username);
    //     await checkReadCoreData();
    //     _errorText = '';
    //   }
    // }
  }

  Future checkReadCoreData(BuildContext context) async {
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
    }
  }

  Future getCoreDataInit(BuildContext context, bool loginAgain) async {
    apisState = ApiState.LOADING;
    var response = await _loginRepository.getCoreDataDetail(
      deviceKey: '0288-7363-6560-2714',
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
              Constants.PAYMENT_GROUP_TXT)
        ],
      );
      if (loginAgain) {
        await login(context);
      }
    }

//     if (response is Failure) {
//       _errorText = response.errorResponse.toString();
//       apisState = ApiState.ERROR;
//     } else {
//       try {
//         coreInitModel = CoreInitModel.fromJson(jsonDecode(response));
//         await Future.wait(
//           [
//             _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.saleModeData),
//                 Constants.SALE_MODE_TXT),
//             _writeCoreInit(
//                 jsonEncode(
//                     coreInitModel!.responseObj!.productData!.productGroup),
//                 Constants.PROD_GROUP_TXT),
//             _writeCoreInit(
//                 jsonEncode(coreInitModel!.responseObj!.productData!.products),
//                 Constants.PROD_TXT),
//             _writeCoreInit(
//                 jsonEncode(coreInitModel!.responseObj!.favoriteGroup),
//                 Constants.FAV_GROUP_TXT),
//             _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.favoriteData),
//                 Constants.FAV_DATA_TXT),
//             _writeCoreInit(jsonEncode(coreInitModel!.responseObj!.reasonGroup),
//                 Constants.REASON_GROUP_TXT),
//             _writeCoreInit(
//                 jsonEncode(
//                     coreInitModel!.responseObj!.payTypeData!.payTypeInfo),
//                 Constants.PAYMENT_GROUP_TXT)
//           ],
//         );
//
//         Constants().printCheckFlow(response, 'CoreDataInit');
//         if (loginAgain) {
//           await login(context);
//         }
//       } catch (e, strack) {
//         _errorText = strack.toString();
//         Constants().printError('$e - $strack');
//         apisState = ApiState.ERROR;
//       }
//     }
    notifyListeners();
  }

  Future _writeCoreInit(String text, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(text);
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

  final List<String> _languageList = ['EN', 'TH'];
}
