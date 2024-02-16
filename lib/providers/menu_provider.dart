// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/finalize_bill_model.dart';
import 'package:cloud_pos/models/order_summary_model.dart';
import 'package:cloud_pos/models/payment_submit_model.dart';
import 'package:cloud_pos/models/product_add_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/service/function/add_product_func.dart';
import 'package:cloud_pos/service/function/payment_func.dart';
import 'package:cloud_pos/service/function/read_file_func.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';

import '../repositorys/repository.dart';

class MenuProvider extends ChangeNotifier {
  final IMenuRepository _menuRepository;
  MenuProvider(this._menuRepository);

  ApiState apiState = ApiState.COMPLETED;
  List<ProductGroup>? prodGroupList;
  List<ReasonGroup>? reasonGroupList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;
  ProductObjModel? productObjModel;
  ProductAddModel? productAddModel;
  PaymentSubmitModel? paymentSubmitModel;
  OrderSummaryModel? orderSummaryModel;
  FinalizeBillModel? finalizeBillModel;
  int? _valueMenuSelect;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _orderId,
      _tranDataFromOpenTran;
  String _exceptionText = '';
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _valueIdReason = TextEditingController();
  final TextEditingController _reasonTextController = TextEditingController();
  final TextEditingController _valueQtyController = TextEditingController();

  String get getOrderId => _orderId!;
  String get getExceptionText => _exceptionText;
  int get getvalueMenuSelect => _valueMenuSelect!;
  String get getvalueReasonGroupSelect => _valueReasonGroupSelect!;
  String get getHtmlOrderSummary => _htmlOrderSummary!;
  TextEditingController get getReasonController => _reasonController;
  TextEditingController get getvalueReason => _valueIdReason;
  TextEditingController get getReasonText => _reasonTextController;
  TextEditingController get getvalueQtyController => _valueQtyController;

  init() async {
    productAddModel = null;
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    await _readData();
    await setReason(0);
    setWhereMenu(prodGroupList![0].productGroupID.toString());

    Constants().printWarning("OrderId : $_orderId");
    SharedPref().setOrderId(_orderId!);
    notifyListeners();
  }

  Future payment({BuildContext? context, String? payAmount}) async {
    if (productAddModel == null ||
        productAddModel!.responseObj!.orderList!.isEmpty) {
      return;
    } else {
      if (int.parse(payAmount!) < productAddModel!.responseObj!.dueAmount!) {
        await LoadingStyle().dialogError(context!,
            error:
                'You pay $payAmount THB.  Pay amount must more than total price.',
            isPopUntil: false);
      } else {
        await PaymentFunc().payment(context: context, payAmount: payAmount);
      }
    }
    notifyListeners();
  }

  Future addProduct(BuildContext context, int prodId, double count,
      String orderDetailId) async {
    LoadingStyle().dialogLoadding(context);
    if (apiState == ApiState.COMPLETED) {
      await AddProductFunc().addProduct(
        context,
        orderDetailId: orderDetailId,
        prodId: prodId,
        count: count,
      );
    }
    notifyListeners();
  }

  Future orderSummary(BuildContext context) async {
    apiState = ApiState.LOADING;
    LoadingStyle().dialogLoadding(context);
    try {
      var response = await _menuRepository.orderSummary(
          deviceKey: '0288-7363-6560-2714', orderId: _orderId);
      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        await LoadingStyle().dialogError(context,
            error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
      } else {
        orderSummaryModel = OrderSummaryModel.fromJson(jsonDecode(response));
        if (orderSummaryModel!.responseCode!.isEmpty) {
          _htmlOrderSummary =
              orderSummaryModel!.responseObj2!.receiptInfo!.receiptHtml;
          Constants().printCheckFlow(response, 'orderSummary');
          apiState = ApiState.COMPLETED;
        } else {
          _exceptionText = orderSummaryModel!.responseText.toString();
          apiState = ApiState.ERROR;
          await LoadingStyle().dialogError(context,
              error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _exceptionText = e.toString();
      apiState = ApiState.ERROR;
      await LoadingStyle().dialogError(context,
          error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
    }
    notifyListeners();
  }

  Future finalizeBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    try {
      var response = await _menuRepository.finalizeBill(
          deviceKey: '0288-7363-6560-2714',
          tranData: json.encode(paymentSubmitModel!.responseObj!.tranData));
      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        await LoadingStyle().dialogError(context,
            error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
      } else {
        finalizeBillModel = FinalizeBillModel.fromJson(jsonDecode(response));
        if (finalizeBillModel!.responseCode!.isEmpty) {
          Constants().printCheckFlow(response, 'finalizeBill');
          apiState = ApiState.COMPLETED;
        } else {
          _exceptionText = finalizeBillModel!.responseText.toString();
          apiState = ApiState.ERROR;
          await LoadingStyle().dialogError(context,
              error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _exceptionText = e.toString();
      apiState = ApiState.ERROR;
      await LoadingStyle().dialogError(context,
          error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
    }
  }

  Future paymentSubmit(BuildContext context, {String? payAmount}) async {
    apiState = ApiState.LOADING;
    try {
      var response = await _menuRepository.paymentSubmit(
          deviceKey: '0288-7363-6560-2714',
          payAmount: payAmount,
          tranData: productAddModel!.responseObj!.tranData!.toJson(),
          payCode: "CS",
          payName: "Cash",
          currencyCode: "THB",
          payId: 1);
      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        await LoadingStyle().dialogError(context,
            error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
      } else {
        paymentSubmitModel = PaymentSubmitModel.fromJson(jsonDecode(response));
        if (productObjModel!.responseCode!.isEmpty) {
          Constants().printCheckFlow(response, 'payment submit');
          apiState = ApiState.COMPLETED;
        } else {
          _exceptionText = productObjModel!.responseText.toString();
          apiState = ApiState.ERROR;
          await LoadingStyle().dialogError(context,
              error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _exceptionText = e.toString();
      apiState = ApiState.ERROR;
      await LoadingStyle().dialogError(context,
          error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
    }
  }

  Future callProductAdd(BuildContext context, double count) async {
    try {
      productObjModel!.responseObj!.productData!.productQty = count;
      var response = await _menuRepository.productAdd(
          deviceKey: '0288-7363-6560-2714',
          prodObj: json.encode(productObjModel!.responseObj));
      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        await LoadingStyle().dialogError(context,
            error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
      } else {
        productAddModel = ProductAddModel.fromJson(jsonDecode(response));
        if (productObjModel!.responseCode!.isEmpty) {
          Constants().printCheckFlow(response, 'product add');
          apiState = ApiState.COMPLETED;
        } else {
          _exceptionText = productObjModel!.responseText.toString();
          apiState = ApiState.ERROR;
          await LoadingStyle().dialogError(context,
              error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _exceptionText = e.toString();
      apiState = ApiState.ERROR;
      await LoadingStyle().dialogError(context,
          error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
    }
  }

  Future callProductObj(
      BuildContext context, int prodId, String orderDetailId) async {
    try {
      var response = await _menuRepository.productObj(
          tranData: _tranDataFromOpenTran,
          productId: prodId.toString(),
          deviceKey: '0288-7363-6560-2714',
          orderDetailId: orderDetailId);
      if (response is Failure) {
        apiState = ApiState.ERROR;
        _exceptionText = response.errorResponse.toString();
        await LoadingStyle().dialogError(context,
            error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
      } else {
        productObjModel = ProductObjModel.fromJson(jsonDecode(response));
        if (productObjModel!.responseCode!.isEmpty) {
          Constants().printInfo(response);
          Constants().printWarning('product obj');
          apiState = ApiState.COMPLETED;
        } else {
          _exceptionText = productObjModel!.responseText.toString();
          apiState = ApiState.ERROR;
          await LoadingStyle().dialogError(context,
              error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
        }
      }
    } catch (e, strack) {
      Constants().printError('$e - $strack');
      _exceptionText = e.toString();
      apiState = ApiState.ERROR;
      await LoadingStyle().dialogError(context,
          error: _exceptionText, isPopUntil: true, popToPage: '/menuPage');
    }
    notifyListeners();
  }

  Future cancelTransaction() async {
    apiState = ApiState.LOADING;
    try {
      var response = await _menuRepository.cancelTran(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          orderId: _orderId,
          reasonIDList: _valueIdReason.text,
          reasonText: _reasonTextController.text);
      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        Constants().printError('${response.code} - ${response.errorResponse}}');
      } else {
        // cancelTranModel = CancelTranModel.fromJson(jsonDecode(response));
        apiState = ApiState.COMPLETED;
        Constants().printCheckFlow(response, 'Cancel Transaction');
      }
    } catch (e, strack) {
      _exceptionText = strack.toString();
      Constants().printError('$e - $strack');
      apiState = ApiState.ERROR;
    }
  }

  Future setReason(int index) async {
    reasonModel = null;
    apiState = ApiState.LOADING;
    _valueReasonGroupSelect = reasonGroupList![index].name;
    try {
      var response = await _menuRepository.reason(
          deviceKey: '0288-7363-6560-2714',
          langId: '1',
          reasonId: reasonGroupList![index].iD.toString());

      if (response is Failure) {
        _exceptionText = response.errorResponse.toString();
        apiState = ApiState.ERROR;
        Constants().printCheckFlow(response.code, response.errorResponse);
      } else {
        reasonModel = ReasonModel.fromJson(jsonDecode(response));
        apiState = ApiState.COMPLETED;
      }
    } catch (e, strack) {
      _exceptionText = strack.toString();
      Constants().printError('$e - $strack');
      apiState = ApiState.ERROR;
    }

    notifyListeners();
  }

  Future addReasonText(int index) async {
    if (_reasonController.text == '' && _valueIdReason.text == '') {
      _reasonController.text = reasonModel!.responseObj![index].text!;
      _valueIdReason.text = reasonModel!.responseObj![index].iD!.toString();
    } else {
      _reasonController.text += ', ${reasonModel!.responseObj![index].text!}';
      _valueIdReason.text +=
          ',${reasonModel!.responseObj![index].iD!.toString()}';
    }
    notifyListeners();
  }

  Future _readData() async {
    apiState = ApiState.LOADING;
    try {
      var value = await Future.wait([
        ReadFileFunc().readProdGroup(),
        ReadFileFunc().readProd(),
        ReadFileFunc().readReason()
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
      reasonGroupList = value[2] as List<ReasonGroup>;
      apiState = ApiState.COMPLETED;
    } catch (e, strack) {
      _exceptionText = strack.toString();
      Constants().printError('$e - $strack');
      apiState = ApiState.ERROR;
    }
  }

  searchMenu(String value) {
    if (value.isEmpty) {
      prodToSearch = [];
    } else {
      prodToSearch = prodList!
          .where(
              (e) => e.productName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  setWhereMenu(String value) {
    _valueMenuSelect = int.parse(value);
    prodToShow = prodList!
        .where((e) => e.productGroupID.toString().contains(value))
        .toList();
    notifyListeners();
  }

  Future clearReasonText() async {
    _reasonController.text = '';
    _valueIdReason.text = '';
    _reasonTextController.text = '';
    _valueQtyController.text = '';
    notifyListeners();
  }

  addCountOrder(BuildContext context, int index) {
    addProduct(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty! + 1,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  removeCountOrder(BuildContext context, int index) {
    addProduct(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty! - 1,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  Future dialogCountOrder(BuildContext context, int index) async {
    productAddModel!.responseObj!.orderList![index].qty =
        double.parse(_valueQtyController.text);
    await addProduct(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty!,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  setExceptionText(String value) {
    _exceptionText = value;
    notifyListeners();
  }

  Future setTranData({String? tranObject, String? orderID}) async {
    _tranDataFromOpenTran = tranObject;
    _orderId = orderID;
  }
}
