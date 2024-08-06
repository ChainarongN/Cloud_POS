// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_pos/models/auth_Info_model.dart';
import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/coupon_inquiry_model.dart';
import 'package:cloud_pos/models/hold_bill_model.dart';
import 'package:cloud_pos/models/member_data_model.dart';
import 'package:cloud_pos/models/payment_qr_request_model.dart';
import 'package:cloud_pos/models/transaction_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/functions/add_product_func.dart';
import 'package:cloud_pos/providers/menu/functions/detect_menu_func.dart';
import 'package:cloud_pos/providers/menu/functions/manage_menu_func.dart';
import 'package:cloud_pos/providers/menu/functions/payment_func.dart';
import 'package:cloud_pos/service/printer.dart';
import 'package:cloud_pos/service/read_file_func.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/dialog_style.dart';
import 'package:cloud_pos/utils/widgets/receipt_bill_print.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../repositorys/repository.dart';

class MenuProvider extends ChangeNotifier {
  final IMenuRepository _menuRepository;
  MenuProvider(this._menuRepository);

  ApiState apiState = ApiState.COMPLETED;
  bool _isLoading = false;
  List<ProductGroup>? prodGroupList;
  List<ProductDept>? prodDeptList;
  List<ReasonGroup>? reasonGroupList;
  List<FavoriteGroup>? favoriteGroupList;
  List<FavoriteData>? favoriteData;
  List<CurrencyInfo>? currencyInfo;
  List<PayTypeInfo>? payTypeInfoList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  List<FavoriteData>? favResultList;
  List<String>? resultPayTypeList;
  ShopData? shopData;
  ComputerName? computerName;

  List computerSaleMode = [];
  List<int>? _selectDiscountList = [];
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;
  ProductObjModel? productObjModel;
  CouponInquiryModel? couponInquiryModel;
  TransactionModel? transactionModel;
  MemberDataModel? memberDataModel;
  AuthInfoModel? authInfoModel;
  HoldBillModel? holdBillModel;
  PaymentQRRequestModel? paymentQRRequestModel;
  int? _valueMenuSelect,
      _valueCurrencyId,
      _valueFavGroup,
      _valueDept,
      _valueTitleSelect = 0,
      indexSaleMode,
      _valuePaytypeIdSelect;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _valueCurrency,
      holdBillName,
      holdBillPhone,
      payAmountMobile = '';
  String _exceptionText = '';
  Timer? timerInquiry;
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController valueIdReason = TextEditingController();
  final TextEditingController reasonTextController = TextEditingController();
  final TextEditingController valueQtyOrderController = TextEditingController();
  final TextEditingController payAmountController = TextEditingController();
  final TextEditingController totalPayListController = TextEditingController();
  final TextEditingController dueAmountController = TextEditingController();
  final TextEditingController payAmountCredit = TextEditingController();
  final TextEditingController paymentRemark = TextEditingController();
  final TextEditingController phoneMemberController = TextEditingController();
  final TextEditingController authInfoUsernameController =
      TextEditingController();
  final TextEditingController authInfoPasswordController =
      TextEditingController();
  TabController? _tabController;
  final ScreenshotController screenshotOrderSumController =
      ScreenshotController();
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController remarkOrderController = TextEditingController();
  // final TextEditingController qrCodeForTestController = TextEditingController();

  // --------------------------- GET ---------------------------
  bool get getLoading => _isLoading;
  TabController get getTabController => _tabController!;
  String get getExceptionText => _exceptionText;
  int get getValueFavGroup => _valueFavGroup!;
  int get getValuePaytypeIdSelect => _valuePaytypeIdSelect!;
  int get getValueDept => _valueDept!;
  int get getvalueMenuSelect => _valueMenuSelect!;
  int get getvalueTitleSelect => _valueTitleSelect!;
  String get getvalueReasonGroupSelect => _valueReasonGroupSelect!;
  String get getHtmlOrderSummary => _htmlOrderSummary!;
  String get getValueCurrency => _valueCurrency!;
  int get getValueCurrencyId => _valueCurrencyId!;
  List<int> get getSelectDiscountList => _selectDiscountList!;

  // ------------------------ Call Data -------------------------
  init(BuildContext context, {TickerProvider? tabThis}) async {
    _isLoading = true;
    payAmountController.text = '';
    totalPayListController.text = '0.00';
    _valueCurrency = 'THB';
    _valueCurrencyId = 1;
    computerSaleMode = [];
    prodGroupList = [];
    prodDeptList = [];
    prodList = [];
    resultPayTypeList = [];
    prodToSearch = [];
    _selectDiscountList = [];
    timerInquiry = Timer(const Duration(seconds: 1200), () {});
    await _readData();
    setPayTypeResult(context);
    showMenuList(context, true,
        prodGroupId: prodGroupList!.first.productGroupID!);
    showFavList(context, favoriteData!.first.pageIndex!);

    SharedPref().setOrderId(transactionModel!.responseObj!.orderID!);
    String deviceType = await SharedPref().getResponsiveDevice();
    if (deviceType == 'tablet') {
      _tabController =
          TabController(length: 6, vsync: tabThis!, initialIndex: 0);
      checkTabView(context);
    } else {
      setValueTitle(context, 0);
    }

    if (apiState == ApiState.COMPLETED) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future paymentMulti(
      {BuildContext? context,
      String? payAmount,
      String? payCode,
      String? payName,
      int? payTypeId,
      String? payRemark,
      bool? fromQuick}) async {
    await PaymentFunc().paymentSubmitFlow(
        context: context,
        payTypeId: payTypeId,
        payAmount: payAmount,
        payCode: payCode,
        payName: payName,
        payRemark: payRemark,
        fromQuick: fromQuick);
    notifyListeners();
  }

  Future paymentCancel(BuildContext context, String payDetailId) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentCancel(context,
        langID: '1',
        payDetailId: payDetailId,
        tranData: json.encode(transactionModel!.responseObj!.tranData));
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'paymentCancel');
    if (apiState == ApiState.COMPLETED) {
      dueAmountController.text =
          transactionModel!.responseObj!.dueAmount.toString();
    }
    notifyListeners();
  }

  Future clearPaymentList(BuildContext context) async {
    DialogStyle().dialogLoadding(context);
    for (var element in transactionModel!.responseObj!.paymentList!) {
      await paymentCancel(context, element.payDetailID.toString());
    }
    Navigator.maybePop(context);
  }

  Future authInfo(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.authInfo(context,
        langID: '1',
        authType: 'cancelbill',
        // username: 'vtec',
        // password: 'vtecsystem'
        username: authInfoUsernameController.text,
        password: authInfoPasswordController.text);
    authInfoModel = await DetectMenuFunc().detectAuthInfo(context, response);
  }

  Future holdBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.holdBill(context,
        langID: '1',
        orderId: transactionModel!.responseObj!.tranData!.orderID,
        customerName: holdBillName,
        customerMobile: holdBillPhone);
    holdBillModel = await DetectMenuFunc().detectHoldBill(context, response);
  }

  Future addProductToList(BuildContext context, int prodId, double count,
      String orderDetailId) async {
    DialogStyle().dialogLoadding(context);
    await AddProductFunc().addProductToList(
      context,
      orderDetailId: orderDetailId,
      prodId: prodId,
      count: count,
    );
    notifyListeners();
  }

  Future eCouponInquiry(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.eCouponInquiry(context,
        langID: '1',
        voucherSN: couponCodeController.text,
        computerCode: '',
        computerName: computerName!.computerName,
        shopCode: shopData!.shopCode,
        shopKey: shopData!.shopKey,
        shopName: shopData!.shopName,
        tranKey: transactionModel!.responseObj!.tranData!.tranKey,
        transactionID: transactionModel!.responseObj!.tranData!.transactionID);
    couponInquiryModel =
        await DetectMenuFunc().detectCouponInquiry(context, response);
  }

  Future eCouponApply(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.eCouponApply(context,
        langID: '1',
        couponSN: couponInquiryModel!.responseObj!.voucherSN,
        tranData: json.encode(transactionModel!.responseObj!.tranData));
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'eCouponApply');
    notifyListeners();
  }

  Future promotionCancel(
      BuildContext context, int indexOutside, int indexInside) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.promotionCancel(
      context,
      langID: '1',
      promoUUID: transactionModel!.responseObj!.promoList![indexOutside]
          .couponList![indexInside].promoUUID,
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'promotionCancel');
    notifyListeners();
  }

  Future orderSummary(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.orderSummary(context,
        orderId: transactionModel!.responseObj!.tranData!.orderID);
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'orderSummary');
    if (apiState == ApiState.COMPLETED) {
      _htmlOrderSummary =
          transactionModel!.responseObj2!.receiptInfo!.receiptHtml;
    }
    notifyListeners();
  }

  Future paymentQRCancel(BuildContext context,
      {String? payTypeCode,
      String? payTypeName,
      int? payTypeId,
      String? payRemark,
      int? edcType}) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentQRCancel(context,
        langID: '1',
        edcType: edcType,
        payAmount: transactionModel!.responseObj!.tranData!.dueAmount!,
        tranData: json.encode(transactionModel!.responseObj!.tranData),
        payTypeCode: payTypeCode, //CS
        payTypeName: payTypeName, //Cash
        currencyCode: _valueCurrency, //THB
        payTypeId: payTypeId, //1
        currencyID: _valueCurrencyId,
        payRemark: payRemark ?? '');
    if (jsonDecode(response)['ResponseCode'] == "") {
      apiState = ApiState.COMPLETED;
      Constants()
          .printCheckFlow(jsonDecode(response).toString(), 'paymentQRCancel');
    } else {
      DialogStyle().dialogError(context,
          error: jsonDecode(response)['ResponseText'],
          isPopUntil: true,
          popToPage: '/menuPage');
      Constants()
          .printCheckError(jsonDecode(response).toString(), 'paymentQRCancel');
    }
    notifyListeners();
  }

  Future paymentQRRequest(BuildContext context,
      {String? payTypeCode,
      String? payTypeName,
      int? payTypeId,
      String? payRemark,
      int? edcType}) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentQRRequest(context,
        langID: '1',
        edcType: edcType,
        payAmount: transactionModel!.responseObj!.tranData!.dueAmount!,
        tranData: json.encode(transactionModel!.responseObj!.tranData),
        payTypeCode: payTypeCode, //CS
        payTypeName: payTypeName, //Cash
        currencyCode: _valueCurrency, //THB
        payTypeId: payTypeId, //1
        currencyID: _valueCurrencyId,
        payRemark: payRemark ?? '');
    paymentQRRequestModel = await DetectMenuFunc()
        .detectPaymentQRRequest(context, response, 'paymentQRRequest');
    // if (apiState == ApiState.COMPLETED) {
    //   qrCodeForTestController.text =
    //       paymentQRRequestModel!.responseObj!.qrCode!;
    // }
    notifyListeners();
  }

  Future paymentQRInquiry(BuildContext context,
      {String? payTypeCode,
      String? payTypeName,
      int? payTypeId,
      String? payRemark,
      int? edcType,
      bool? isRecursive}) async {
    apiState = ApiState.LOADING;
    if (isRecursive!) {
      timerInquiry = Timer.periodic(const Duration(seconds: 5), (timer) async {
        var response = await _menuRepository.paymentQRInquiry(context,
            langID: '1',
            edcType: edcType,
            payAmount: transactionModel!.responseObj!.tranData!.dueAmount!,
            tranData: json.encode(transactionModel!.responseObj!.tranData),
            payTypeCode: payTypeCode, //CS
            payTypeName: payTypeName, //Cash
            currencyCode: _valueCurrency, //THB
            payTypeId: payTypeId, //1
            currencyID: _valueCurrencyId,
            payRemark: payRemark ?? '');
        if (jsonDecode(response)['ResponseCode'] != "90") {
          timer.cancel();
          transactionModel = await DetectMenuFunc()
              .detectTransaction(context, response, 'paymentQRInquiry');
          if (apiState == ApiState.COMPLETED) {
            await finalizeBill(context);
            notifyListeners();
          }
        } else {
          Constants().printCheckFlow(
              jsonDecode(response).toString(), 'paymentQRInquiry');
        }
      });
    } else {
      var response = await _menuRepository.paymentQRInquiry(context,
          langID: '1',
          edcType: edcType,
          payAmount: transactionModel!.responseObj!.tranData!.dueAmount!,
          tranData: json.encode(transactionModel!.responseObj!.tranData),
          payTypeCode: payTypeCode, //CS
          payTypeName: payTypeName, //Cash
          currencyCode: _valueCurrency, //THB
          payTypeId: payTypeId, //1
          currencyID: _valueCurrencyId,
          payRemark: payRemark ?? '');
      if (jsonDecode(response)['ResponseCode'] != "90") {
        timerInquiry!.cancel();
        transactionModel = await DetectMenuFunc()
            .detectTransaction(context, response, 'paymentQRInquiry');
        if (apiState == ApiState.COMPLETED) {
          await finalizeBill(context);
          notifyListeners();
        }
      } else {
        Constants().printCheckFlow(
            jsonDecode(response).toString(), 'paymentQRInquiry');
      }
    }
  }

  Future receiptBillPrint(BuildContext context) async {
    apiState = ApiState.LOADING;
    String deviceType = await SharedPref().getResponsiveDevice();
    var response = await _menuRepository.receiptBillPrint(context,
        orderId: transactionModel!.responseObj!.tranData!.orderID);
    await DetectMenuFunc()
        .detecTreceiptBillPrint(context, response, 'receiptBillPrint');
    if (apiState == ApiState.COMPLETED) {
      _htmlOrderSummary =
          jsonDecode(response)['ResponseObj2']['ReceiptInfo']['ReceiptHtml'];
      showReceiptBillPrint(
        context,
        _htmlOrderSummary!,
        screenshotOrderSumController,
        () {
          screenshotOrderSumController
              .capture(delay: const Duration(seconds: 1), pixelRatio: 1.2)
              .then((Uint8List? value) async {
            Printer().printReceipt(value!).then((value) async {
              if (deviceType == 'tablet') {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/homePage'));
              } else {
                var homePvd = context.read<HomeProvider>();
                await homePvd.openTransaction(context).then((value) {
                  if (homePvd.apisState == ApiState.COMPLETED) {
                    setTranData(tranModel: json.encode(homePvd.openTranModel))
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/menuPage', (route) => false);
                    });
                  }
                });
              }
            });
          });
        },
      );
    }
  }

  Future finalizeBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.finalizeBill(
      context,
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'finalizeBill');
    if (apiState == ApiState.COMPLETED) {
      DialogStyle().dialogPaymentProcess(
        context,
        text: transactionModel!.responseObj!.paymentList!.last.cashChange
            .toString(),
        onPressed: () async {
          DialogStyle().dialogLoadding(context);
          receiptBillPrint(context);
        },
      );
    }
  }

  Future paymentSubmit(BuildContext context,
      {String? payAmount,
      String? payCode,
      String? payName,
      int? payTypeId,
      String? payRemark}) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentSubmit(context,
        payAmount: payAmount,
        tranData: json.encode(transactionModel!.responseObj!.tranData),
        payCode: payCode, //CS
        payName: payName, //Cash
        currencyCode: _valueCurrency, //THB
        payTypeId: payTypeId, //1
        currencyID: _valueCurrencyId,
        payRemark: payRemark ?? '');

    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'paymentSubmit');
    if (apiState == ApiState.COMPLETED) {
      dueAmountController.text =
          transactionModel!.responseObj!.dueAmount.toString();
    }
  }

  Future productAdd(BuildContext context, double count, bool isCombo) async {
    apiState = ApiState.LOADING;
    try {
      if (isCombo) {
        productObjModel!.responseObj!.comboData!.productQty = count;
      } else {
        productObjModel!.responseObj!.productData!.productQty = count;
      }

      var response = await _menuRepository.productAdd(context,
          langID: '1', prodObj: json.encode(productObjModel!.responseObj));
      transactionModel = await DetectMenuFunc()
          .detectTransaction(context, response, 'productAdd');
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      // DialogStyle().dialogError(context,
      //     error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }
    notifyListeners();
  }

  Future orderProcess(
    BuildContext context,
    double count,
    String editOrderId,
    String modifyId,
    String productId,
  ) async {
    DialogStyle().dialogLoadding(context);
    String deviceType = await SharedPref().getResponsiveDevice();
    try {
      apiState = ApiState.LOADING;
      var response = await _menuRepository.orderProcess(context,
          langID: '1',
          editOrderID: editOrderId,
          modifyId: modifyId,
          orderQty: count.toString(),
          productID: productId,
          tranData: json.encode(transactionModel!.responseObj!.tranData));
      transactionModel = await DetectMenuFunc()
          .detectTransaction(context, response, 'orderProcess');
      if (apiState == ApiState.COMPLETED) {
        if (deviceType == 'tablet') {
          Navigator.of(context).popUntil(ModalRoute.withName('/menuPage'));
        } else {
          Navigator.of(context)
              .popUntil(ModalRoute.withName('/shopingCartPage'));
        }
      }
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError('$e // $strack');

      if (deviceType == 'tablet') {
        DialogStyle().dialogError(context,
            error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
      } else {
        DialogStyle().dialogError(context,
            error: e.toString(),
            isPopUntil: true,
            popToPage: '/shopingCartPage');
      }
    }
    notifyListeners();
  }

  Future productObj(
      BuildContext context, int prodId, String orderDetailId) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.productObj(context,
        tranData: json.encode(transactionModel!.responseObj!.tranData),
        productId: prodId.toString(),
        orderDetailId: orderDetailId);
    productObjModel =
        await DetectMenuFunc().detectProductObj(context, response);
  }

  Future cancelTransaction(BuildContext context, {int? indexSaleMode}) async {
    apiState = ApiState.LOADING;
    await clearApplyCoupon(context);
    String deviceType = await SharedPref().getResponsiveDevice();
    var response = await _menuRepository.cancelTran(context,
        langId: '1',
        orderId: transactionModel!.responseObj!.orderID,
        reasonIDList: valueIdReason.text,
        reasonText: reasonTextController.text,
        staffId: authInfoModel!.responseObj!.staffInfo!.staffID.toString());
    cancelTranModel =
        await DetectMenuFunc().detectCancelTran(context, response);
    if (apiState == ApiState.COMPLETED) {
      if (deviceType == 'tablet') {
        Navigator.of(context).popUntil(ModalRoute.withName('/homePage'));
      } else {
        var homePvd = context.read<HomeProvider>();
        DialogStyle().dialogLoadding(context);
        if (indexSaleMode == null) {
          await homePvd.openTransaction(context).then((value) {
            if (homePvd.apisState == ApiState.COMPLETED) {
              setTranData(tranModel: json.encode(homePvd.openTranModel))
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/menuPage', (route) => false);
              });
            }
          });
        } else {
          await homePvd
              .openTransaction(context, index: indexSaleMode)
              .then((value) {
            if (homePvd.apisState == ApiState.COMPLETED) {
              setTranData(tranModel: json.encode(homePvd.openTranModel))
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/menuPage', (route) => false);
              });
            }
          });
        }
      }
    }
  }

  Future memberData(BuildContext context, String phone) async {
    apiState = ApiState.LOADING;
    var response =
        await _menuRepository.memberData(context, phoneMember: phone);
    memberDataModel =
        await DetectMenuFunc().detectMemberData(context, response);
  }

  Future memberApply(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberApply(
      context,
      memberId: memberDataModel!.responseObj!.memberInfo!.memberID.toString(),
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'memberApply');
  }

  Future memberCancel(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberCancel(
      context,
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'memberCancel');
  }

  Future addReasonText(int index) async {
    if (reasonController.text == '' && valueIdReason.text == '') {
      reasonController.text = authInfoModel!.responseObj2![index].text!;
      valueIdReason.text = authInfoModel!.responseObj2![index].iD!.toString();
    } else {
      reasonController.text += ', ${authInfoModel!.responseObj2![index].text!}';
      valueIdReason.text +=
          ',${authInfoModel!.responseObj2![index].iD!.toString()}';
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
        ReadFileFunc().readPaymentInfo(),
        ReadFileFunc().readFavoriteGroup(),
        ReadFileFunc().readFavoriteData(),
        ReadFileFunc().readShopData(),
        ReadFileFunc().readComputerName(),
        ReadFileFunc().readCurrencyInfo(),
        ReadFileFunc().readProdDept(),
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
      reasonGroupList = value[2] as List<ReasonGroup>;
      payTypeInfoList = value[3] as List<PayTypeInfo>;
      favoriteGroupList = value[4] as List<FavoriteGroup>;
      favoriteData = value[5] as List<FavoriteData>;
      shopData = value[6] as ShopData;
      computerName = value[7] as ComputerName;
      currencyInfo = value[8] as List<CurrencyInfo>;
      prodDeptList = value[9] as List<ProductDept>;

      computerSaleMode = computerName!.saleModeList!.split(',');
      apiState = ApiState.COMPLETED;
    } catch (e, strack) {
      _exceptionText = strack.toString();
      Constants().printError('$e - $strack');
      apiState = ApiState.ERROR;
    }
    notifyListeners();
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

  Future showFavList(BuildContext context, int pageGroup) async {
    _valueFavGroup = pageGroup;
    favResultList = [];
    await ManageMenuFunc().showDataFav(context, pageGroup);
    notifyListeners();
  }

  Future showMenuList(BuildContext context, bool fromProdGroup,
      {int? prodGroupId, int? prodDeptId}) async {
    if (fromProdGroup) {
      _valueMenuSelect = prodGroupId;
      _valueDept = prodDeptList!
          .where((element) => element.productGroupID == prodGroupId)
          .first
          .productDeptID;
      ManageMenuFunc().showMenuData(context, prodGroupId!, _valueDept!);
    } else {
      _valueDept = prodDeptId;
      ManageMenuFunc().showMenuData(context, _valueMenuSelect!, prodDeptId!);
    }
    notifyListeners();
  }

  checkTabView(BuildContext context) {
    _tabController!.addListener(() async {
      switch (_tabController!.index) {
        case 5:
          if (transactionModel!.responseObj!.orderList!.isEmpty) {
            await DialogStyle().dialogError(context,
                error: LocaleKeys.must_have_at_least_1_order.tr(),
                isPopUntil: true,
                popToPage: '/menuPage');
            setTabToPayment(0);
          }
          break;
        case 1:
          var result =
              favoriteGroupList!.where((element) => element.pageType == 0);
          if (result.isNotEmpty) {
            showFavList(context, result.first.pageIndex!);
          } else {
            favResultList = [];
          }
          break;
        case 2:
          var result =
              favoriteGroupList!.where((element) => element.pageType == 1);
          if (result.isNotEmpty) {
            showFavList(context, result.first.pageIndex!);
          } else {
            favResultList = [];
          }
          break;
        case 0:
          showMenuList(context, true,
              prodGroupId: prodGroupList!.first.productGroupID!);
          break;
      }
    });
  }

  String sumTotalDiscountCoupon(int index, String frag) {
    double result = 0;
    result = transactionModel!.responseObj!.orderList![index].promoItemList!
        .map((item) => item.totalDiscount)
        .reduce((a, b) => a! + b!)!;
    if (frag == 'salesPrice') {
      result = transactionModel!.responseObj!.orderList![index].retailPrice! -
          result;
    }
    return result.toString();
  }

  Future clearApplyCoupon(BuildContext context) async {
    if (transactionModel!.responseObj!.promoList!.isNotEmpty) {
      var promoList = transactionModel!.responseObj!.promoList;
      for (var i = 0; i < promoList!.length; i++) {
        if (promoList[i].couponList!.isNotEmpty) {
          for (var j = 0; j < promoList[i].couponList!.length; j++) {
            await promotionCancel(context, i, j);
          }
        }
      }
    }
  }

  String getProdName(int prodId) {
    var result = prodList!.where((element) => element.productID == prodId);
    return result.first.productName!;
  }

  String getProdImage(int prodId) {
    var result = prodList!.where((element) => element.productID == prodId);
    return result.first.imageFileName!;
  }

  // --------------------------- SET ---------------------------\

  setPayTypeResult(BuildContext context) {
    var homePvd = context.read<HomeProvider>();
    final computerSplitList = computerName!.payTypeList!.split(',').toSet();
    final saleModeSplitList = homePvd.saleModeDataList!
        .where((element) =>
            element.saleModeID == transactionModel!.responseObj!.saleModeID)
        .first
        .payTypeList!
        .split(',')
        .toSet();
    resultPayTypeList =
        computerSplitList.intersection(saleModeSplitList).toList();

// first select payment for mobile
    if (resultPayTypeList!.isNotEmpty) {
      _valuePaytypeIdSelect = int.parse(resultPayTypeList![0]);
    } else {
      _valuePaytypeIdSelect = null;
    }
    notifyListeners();
  }

  setValueTitle(BuildContext context, int value) {
    _valueTitleSelect = value;
    if (value == 1) {
      var result = favoriteGroupList!.where((element) => element.pageType == 0);
      if (result.isNotEmpty) {
        showFavList(context, result.first.pageIndex!);
      } else {
        favResultList = [];
      }
    } else if (value == 2) {
      var result = favoriteGroupList!.where((element) => element.pageType == 1);
      if (result.isNotEmpty) {
        showFavList(context, result.first.pageIndex!);
      } else {
        favResultList = [];
      }
    } else if (value == 0) {
      showMenuList(context, true,
          prodGroupId: prodGroupList!.first.productGroupID!);
    }
    notifyListeners();
  }

  Future setQtyComment(
      int indexCommentGroup, int commentindex, bool selected) async {
    List<Comments> commentList =
        productObjModel!.responseObj!.productData!.comments!;
    if (productObjModel!.responseObj!.productData!
            .commentGroup![indexCommentGroup].isMulti ==
        0) {
      for (var element in commentList) {
        if (element.groupID ==
            productObjModel!.responseObj!.productData!
                .commentGroup![indexCommentGroup].groupID) {
          element.qty = 0;
        }
      }
    }
    if (selected) {
      productObjModel!.responseObj!.productData!.comments![commentindex].qty =
          1.0;
    } else {
      productObjModel!.responseObj!.productData!.comments![commentindex].qty =
          0.0;
    }
    notifyListeners();
  }

  Future setQtyCombo(bool selected, int indexGroup, int indexitemList,
      int indexCommentGroup, int indexComment, bool isComment) async {
    List<Comments> commentList = productObjModel!.responseObj!.comboData!
        .group![indexGroup].itemList![indexitemList].comments!;

    if (isComment) {
      if (productObjModel!.responseObj!.comboData!
              .commentGroup![indexCommentGroup].isMulti ==
          0) {
        for (var element in commentList) {
          if (element.groupID ==
              productObjModel!.responseObj!.comboData!
                  .commentGroup![indexCommentGroup].groupID) {
            element.qty = 0;
          }
        }
      }
      if (selected) {
        productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].comments![indexComment].qty = 1.0;
      } else {
        productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].comments![indexComment].qty = 0.0;
      }
    } else {
      if (selected) {
        productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].qtyValue = 1.0;
      } else {
        productObjModel!.responseObj!.comboData!.group![indexGroup]
            .itemList![indexitemList].qtyValue = 0.0;
      }
    }
    notifyListeners();
  }

  Future setRemarkComboSet(
      String value, int indexGroup, int indexitemList) async {
    var remark = productObjModel!.responseObj!.comboData!.group![indexGroup]
        .itemList![indexitemList].comments!
        .where((element) => element.groupID == -1);
    remark.first.commentText = value;
    remark.first.qty = 1.0;
  }

  Future setSelectDiscount(int prodId) async {
    if (_selectDiscountList!.contains(prodId)) {
      _selectDiscountList!.removeWhere((item) => item == prodId);
    } else {
      _selectDiscountList!.add(prodId);
    }
    notifyListeners();
  }

  setTabToPayment(int page) {
    _tabController!.animateTo(page);
    notifyListeners();
  }

  Future clearReasonText() async {
    reasonController.text = '';
    valueIdReason.text = '';
    reasonTextController.text = '';
    valueQtyOrderController.text = '';
    notifyListeners();
  }

  Future clearPaymentField() async {
    paymentRemark.text = '';
    payAmountCredit.text = '';
    notifyListeners();
  }

  Future clearField() async {
    phoneMemberController.text = '';
    couponCodeController.text = '';
    notifyListeners();
  }

  manageCountOrder(BuildContext context, int index, String frag) {
    if (frag == 'add') {
      orderProcess(
          context,
          transactionModel!.responseObj!.orderList![index].qty! + 1,
          transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '2',
          transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    } else if (frag == 'remove') {
      if (transactionModel!.responseObj!.orderList![index].qty! > 1) {
        orderProcess(
            context,
            transactionModel!.responseObj!.orderList![index].qty! - 1,
            transactionModel!.responseObj!.orderList![index].orderDetailID
                .toString(),
            '2',
            transactionModel!.responseObj!.orderList![index].productID!
                .toString());
      }
    } else if (frag == 'dialog') {
      orderProcess(
          context,
          double.parse(valueQtyOrderController.text),
          transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '2',
          transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    } else {
      orderProcess(
          context,
          transactionModel!.responseObj!.orderList![index].qty!,
          transactionModel!.responseObj!.orderList![index].orderDetailID
              .toString(),
          '1',
          transactionModel!.responseObj!.orderList![index].productID!
              .toString());
    }
  }

  Future setPayAmountField(int value) async {
    if (payAmountController.text.isEmpty) {
      payAmountController.text = value.toString();
    } else {
      double total = double.parse(payAmountController.text);
      double sum = total + value;
      payAmountController.text = sum.toString();
    }
    notifyListeners();
  }

  Future clearPayAmount() async {
    payAmountController.clear();
    notifyListeners();
  }

  Future clearResultFav() async {
    favResultList = [];
    notifyListeners();
  }

  setExceptionText(String value) {
    _exceptionText = value;
    notifyListeners();
  }

  Future setValuePayTypeSelect(int value) async {
    _valuePaytypeIdSelect = value;
    notifyListeners();
  }

  Future setTranData({String? tranModel}) async {
    transactionModel = TransactionModel.fromJson(jsonDecode(tranModel!));
  }

  Future setCouponCodeController(String value) async {
    couponCodeController.text = value;
    notifyListeners();
  }

  setCouponCodeControllerForTest() {
    couponCodeController.text = '2623381B99D9438FB8360BC0BAC1A08393';
    notifyListeners();
  }

  setPhoneMemberForTest() {
    phoneMemberController.text = '083-686-9334';
    notifyListeners();
  }

  setCancelUserNameForTest() {
    authInfoUsernameController.text = '1';
    authInfoPasswordController.text = '1';
    notifyListeners();
  }

  //   Future reOrderableDataFav(
//       BuildContext context, int oldIndex, int newIndex) async {
//     await ManageFav1Func()
//         .changeIndexFav(context, oldIndex, newIndex, _valueFavGroup!);
//
//     notifyListeners();
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final File file = File('${directory.path}/${Constants.FAV_DATA_TXT}');
//     await file.writeAsString(json.encode(favoriteData!));
//   }
}
