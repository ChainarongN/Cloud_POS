// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/finalize_bill_model.dart';
import 'package:cloud_pos/models/order_summary_model.dart';
import 'package:cloud_pos/models/pay_amount_model.dart';
import 'package:cloud_pos/models/payment_submit_model.dart';
import 'package:cloud_pos/models/product_add_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/functions/add_product_func.dart';
import 'package:cloud_pos/pages/menu/functions/detect_menu_func.dart';
import 'package:cloud_pos/pages/menu/functions/payment_func.dart';
import 'package:cloud_pos/pages/menu/functions/read_file_func.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:flutter/material.dart';
import '../repositorys/repository.dart';

class MenuProvider extends ChangeNotifier {
  final IMenuRepository _menuRepository;
  MenuProvider(this._menuRepository);

  ApiState apiState = ApiState.COMPLETED;
  bool _isLoading = false;
  List<ProductGroup>? prodGroupList;
  List<ReasonGroup>? reasonGroupList;
  List<PayTypeInfo>? payTypeInfoList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  List<PayAmountModel>? payAmountList = [];
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;
  ProductObjModel? productObjModel;
  ProductAddModel? productAddModel;
  PaymentSubmitModel? paymentSubmitModel;
  OrderSummaryModel? orderSummaryModel;
  FinalizeBillModel? finalizeBillModel;
  int? _valueMenuSelect, _valueCurrencyId;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _orderId,
      _tranDataFromOpenTran,
      _valueCurrency;
  String _exceptionText = '';

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _valueIdReason = TextEditingController();
  final TextEditingController _reasonTextController = TextEditingController();
  final TextEditingController _valueQtyOrderController =
      TextEditingController();
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _totalPayListController = TextEditingController();
  final TextEditingController _dueAmountController = TextEditingController();
  final TextEditingController _payAmountCredit = TextEditingController();
  final TextEditingController _paymentRemark = TextEditingController();
  TabController? _tabController;

  // --------------------------- GET ---------------------------
  bool get getLoading => _isLoading;
  TabController get getTabController => _tabController!;
  String get getOrderId => _orderId!;
  String get getExceptionText => _exceptionText;
  int get getvalueMenuSelect => _valueMenuSelect!;
  String get getvalueReasonGroupSelect => _valueReasonGroupSelect!;
  String get getHtmlOrderSummary => _htmlOrderSummary!;
  String get getValueCurrency => _valueCurrency!;
  int get getValueCurrencyId => _valueCurrencyId!;
  TextEditingController get getReasonController => _reasonController;
  TextEditingController get getvalueReason => _valueIdReason;
  TextEditingController get getReasonText => _reasonTextController;
  TextEditingController get getvalueQtyOrderController =>
      _valueQtyOrderController;
  TextEditingController get getPayAmountController => _payAmountController;
  TextEditingController get getTotalPayController => _totalPayListController;
  TextEditingController get getDueAmountController => _dueAmountController;
  TextEditingController get getPayAmountCredit => _payAmountCredit;
  TextEditingController get getPaymentRemark => _paymentRemark;

  // ------------------------ Call Data -------------------------
  init(BuildContext context, TickerProvider tabThis) async {
    _isLoading = true;
    _payAmountController.text = '';
    _totalPayListController.text = '0.00';
    _tabController = TabController(length: 6, vsync: tabThis);
    _valueCurrency = 'THB';
    _valueCurrencyId = 1;
    productAddModel = null;
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    payAmountList = [];
    await _readData();
    await setReason(context, 0);
    setWhereMenu(prodGroupList![0].productGroupID.toString());

    Constants().printWarning("OrderId : $_orderId");
    SharedPref().setOrderId(_orderId!);
    checkPaymentTab(context);

    if (apiState == ApiState.COMPLETED) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future paymentCash({BuildContext? context, String? payAmount}) async {
    if (productAddModel == null ||
        productAddModel!.responseObj!.orderList!.isEmpty) {
      return;
    } else {
      if (int.parse(payAmount!) < double.parse(_dueAmountController.text)) {
        await LoadingStyle().dialogError(context!,
            error:
                'You pay $payAmount THB.  Pay amount must more than total price.',
            isPopUntil: false);
      } else {
        await PaymentFunc()
            .paymentCashType(context: context, payAmount: payAmount);
      }
    }
    notifyListeners();
  }

  Future managePayAmountList(BuildContext context, String frag,
      {String? payName,
      String? payCode,
      int? payTypeId,
      String? price,
      int? indexForRemove,
      String? payRemark}) async {
    if (frag == 'add') {
      payAmountList!.add(
        PayAmountModel(
            payTypeId: payTypeId,
            payCode: payCode,
            payName: payName,
            price: double.parse(price!),
            payRemark: payRemark ?? ''),
      );
      _payAmountController.text = '';
    } else if (frag == 'remove') {
      payAmountList!.removeAt(indexForRemove!);
    } else if (frag == 'clear') {
      payAmountList = [];
    }
    num sum = 0;
    for (var element in payAmountList!) {
      sum += element.price!;
    }
    _totalPayListController.text = sum.toString();
    if (sum >= double.parse(_dueAmountController.text)) {
      LoadingStyle().dialogLoadding(context);
      for (var i = 0; i < payAmountList!.length; i++) {
        await paymentSubmit(context,
            payAmount: payAmountList![i].price.toString(),
            payCode: payAmountList![i].payCode,
            payName: payAmountList![i].payName,
            payTypeId: payAmountList![i].payTypeId,
            payRemark: payAmountList![i].payRemark);
      }
      if (apiState == ApiState.COMPLETED) {
        await finalizeBill(context);
      }
    }
    notifyListeners();
  }

  Future addProductToList(BuildContext context, int prodId, double count,
      String orderDetailId) async {
    LoadingStyle().dialogLoadding(context);
    await AddProductFunc().addProductToList(
      context,
      orderDetailId: orderDetailId,
      prodId: prodId,
      count: count,
    );
    if (apiState == ApiState.COMPLETED) {
      _dueAmountController.text =
          productAddModel!.responseObj!.dueAmount.toString();
    }
    notifyListeners();
  }

  Future orderSummary(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.orderSummary(
        deviceKey: '0288-7363-6560-2714', orderId: _orderId);
    orderSummaryModel =
        await DetectMenuFunc().detectOrderSummary(context, response);
    if (apiState == ApiState.COMPLETED) {
      _htmlOrderSummary =
          orderSummaryModel!.responseObj2!.receiptInfo!.receiptHtml;
    }
    notifyListeners();
  }

  Future finalizeBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.finalizeBill(
        deviceKey: '0288-7363-6560-2714',
        tranData: json.encode(paymentSubmitModel!.responseObj!.tranData));
    finalizeBillModel =
        await DetectMenuFunc().detectFinalizeBill(context, response);
    if (apiState == ApiState.COMPLETED) {
      await LoadingStyle().dialogPayment2(context,
          text: paymentSubmitModel!.responseObj!.paymentList!.last.cashChange
              .toString(),
          popUntil: true,
          popToPage: '/homePage');
    }
  }

  Future paymentSubmit(BuildContext context,
      {String? payAmount,
      String? payCode,
      String? payName,
      int? payTypeId,
      String? payRemark}) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentSubmit(
        deviceKey: '0288-7363-6560-2714',
        payAmount: payAmount,
        tranData: productAddModel!.responseObj!.tranData!.toJson(),
        payCode: payCode, //CS
        payName: payName, //Cash
        currencyCode: _valueCurrency, //THB
        payTypeId: payTypeId, //1
        currencyID: _valueCurrencyId,
        payRemark: payRemark ?? '');

    paymentSubmitModel =
        await DetectMenuFunc().detectPaymentSubmit(context, response);
    if (apiState == ApiState.COMPLETED) {
      _dueAmountController.text =
          paymentSubmitModel!.responseObj!.dueAmount.toString();
    }
  }

  Future productAdd(BuildContext context, double count) async {
    productObjModel!.responseObj!.productData!.productQty = count;
    apiState = ApiState.LOADING;
    var response = await _menuRepository.productAdd(
        deviceKey: '0288-7363-6560-2714',
        prodObj: json.encode(productObjModel!.responseObj));
    productAddModel =
        await DetectMenuFunc().detectProductAdd(context, response);
  }

  Future productObj(
      BuildContext context, int prodId, String orderDetailId) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.productObj(
        tranData: _tranDataFromOpenTran,
        productId: prodId.toString(),
        deviceKey: '0288-7363-6560-2714',
        orderDetailId: orderDetailId);
    productObjModel =
        await DetectMenuFunc().detectProductObj(context, response);
  }

  Future cancelTransaction(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.cancelTran(
        deviceKey: '0288-7363-6560-2714',
        langId: '1',
        orderId: _orderId,
        reasonIDList: _valueIdReason.text,
        reasonText: _reasonTextController.text);
    cancelTranModel =
        await DetectMenuFunc().detectCancelTran(context, response);
    if (apiState == ApiState.COMPLETED) {
      Navigator.of(context).popUntil(ModalRoute.withName('/homePage'));
    }
  }

  Future setReason(BuildContext context, int index) async {
    reasonModel = null;
    apiState = ApiState.LOADING;
    _valueReasonGroupSelect = reasonGroupList![index].name;
    var response = await _menuRepository.reason(
        deviceKey: '0288-7363-6560-2714',
        langId: '1',
        reasonId: reasonGroupList![index].iD.toString());
    reasonModel = await DetectMenuFunc().detectReason(context, response);
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
        ReadFileFunc().readReason(),
        ReadFileFunc().readPaymentInfo()
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
      reasonGroupList = value[2] as List<ReasonGroup>;
      payTypeInfoList = value[3] as List<PayTypeInfo>;
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

  checkPaymentTab(BuildContext context) {
    _tabController!.addListener(() async {
      if (_tabController!.index == 5) {
        if (productAddModel == null ||
            productAddModel!.responseObj!.orderList!.isEmpty) {
          await LoadingStyle().dialogError(context,
              error: 'Must have at least 1 order.',
              isPopUntil: true,
              popToPage: '/menuPage');
          setTabToPayment(0);
        }
      }
    });
  }

  // --------------------------- SET ---------------------------\
  setTabToPayment(int page) {
    _tabController!.animateTo(page);
    notifyListeners();
  }

  Future clearReasonText() async {
    _reasonController.text = '';
    _valueIdReason.text = '';
    _reasonTextController.text = '';
    _valueQtyOrderController.text = '';
    notifyListeners();
  }

  Future clearPaymentField() async {
    _paymentRemark.text = '';
    _payAmountCredit.text = '';
    notifyListeners();
  }

  addCountOrder(BuildContext context, int index) {
    addProductToList(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty! + 1,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  removeCountOrder(BuildContext context, int index) {
    addProductToList(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty! - 1,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  Future dialogCountOrder(BuildContext context, int index) async {
    productAddModel!.responseObj!.orderList![index].qty =
        double.parse(_valueQtyOrderController.text);
    await addProductToList(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty!,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
  }

  Future setPayAmountField(int value) async {
    if (_payAmountController.text.isEmpty) {
      _payAmountController.text = value.toString();
    } else {
      double total = double.parse(_payAmountController.text);
      double sum = total + value;
      _payAmountController.text = sum.toString();
    }
    notifyListeners();
  }

  Future clearPayAmount() async {
    _payAmountController.clear();
    notifyListeners();
  }

  setExceptionText(String value) {
    _exceptionText = value;
    notifyListeners();
  }

  Future setTranData({String? tranObject, String? orderID}) async {
    _tranDataFromOpenTran = tranObject;
    _orderId = orderID;
  }

  final List<String> currencyitems = ['THB'];
}
