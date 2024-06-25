// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:cloud_pos/models/auth_Info_model.dart';
import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/coupon_inquiry_model.dart';
import 'package:cloud_pos/models/hold_bill_model.dart';
import 'package:cloud_pos/models/member_data_model.dart';
import 'package:cloud_pos/models/transaction_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/providers/menu/functions/add_product_func.dart';
import 'package:cloud_pos/providers/menu/functions/detect_menu_func.dart';
import 'package:cloud_pos/providers/menu/functions/manage_fav_func.dart';
import 'package:cloud_pos/providers/menu/functions/payment_func.dart';
import 'package:cloud_pos/providers/menu/functions/read_file_func.dart';
import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
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
  List<ReasonGroup>? reasonGroupList;
  List<FavoriteGroup>? favoriteGroupList;
  List<FavoriteData>? favoriteData;
  List<CurrencyInfo>? currencyInfo;
  List<PayTypeInfo>? payTypeInfoList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
  List<FavoriteData>? favResultList;
  ShopData? shopData;
  ComputerName? computerName;

  List<int>? _selectDiscountList = [];
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;
  ProductObjModel? productObjModel;
  CouponInquiryModel? couponInquiryModel;
  TransactionModel? transactionModel;
  MemberDataModel? memberDataModel;
  AuthInfoModel? authInfoModel;
  HoldBillModel? holdBillModel;
  int? _valueMenuSelect,
      _valueCurrencyId,
      _valueFavGroup,
      _valueTitleSelect = 0;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _valueCurrency,
      holdBillName,
      holdBillPhone,
      usernameCancel,
      passwordCancel,
      payAmount = '';
  String _exceptionText = '';
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
  TabController? _tabController;
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController couponCodeController = TextEditingController();

  // --------------------------- GET ---------------------------
  bool get getLoading => _isLoading;
  TabController get getTabController => _tabController!;
  String get getExceptionText => _exceptionText;
  int get getValueFavGroup => _valueFavGroup!;
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
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    _selectDiscountList = [];

    await _readData();
    await setReason(context, 0);
    setWhereMenu(prodGroupList![0].productGroupID.toString());
    showFavList(context, favoriteData!.first.pageIndex!);

    Constants()
        .printWarning("OrderId : ${transactionModel!.responseObj!.orderID}");
    SharedPref().setOrderId(transactionModel!.responseObj!.orderID!);
    String deviceType = await SharedPref().getResponsiveDevice();
    if (deviceType == 'tablet') {
      _tabController = TabController(length: 6, vsync: tabThis!);
      checkPaymentTab(context);
    }
    if (apiState == ApiState.COMPLETED) {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future paymentCash({BuildContext? context, String? payAmount}) async {
    if (transactionModel!.responseObj!.orderList!.isEmpty) {
      return;
    } else {
      if (int.parse(payAmount!) < transactionModel!.responseObj!.dueAmount!) {
        await LoadingStyle().dialogError(context!,
            error:
                'You pay $payAmount THB.  ${LocaleKeys.pay_amount_must_more_than_total_price.tr()}',
            isPopUntil: false);
      } else {
        await PaymentFunc()
            .paymentCashType(context: context, payAmount: payAmount);
      }
    }
    notifyListeners();
  }

  Future paymentMulti(
      {BuildContext? context,
      String? payAmount,
      String? payCode,
      String? payName,
      int? payTypeId,
      String? payRemark}) async {
    if (transactionModel!.responseObj!.orderList!.isEmpty) {
      return;
    } else {
      LoadingStyle().dialogLoadding(context!);
      await paymentSubmit(context,
          payAmount: payAmount,
          payCode: payCode,
          payName: payName,
          payTypeId: payTypeId,
          payRemark: payRemark);
      if (transactionModel!.responseObj!.tranData!.dueAmount! == 0) {
        await finalizeBill(context);
      }
      Navigator.maybePop(context);
    }
    notifyListeners();
  }

  Future paymentCancel(BuildContext context, String payDetailId) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.paymentCancel(
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
    LoadingStyle().dialogLoadding(context);
    for (var element in transactionModel!.responseObj!.paymentList!) {
      await paymentCancel(context, element.payDetailID.toString());
    }
    Navigator.maybePop(context);
  }

  Future authInfo(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.authInfo(
        langID: '1',
        authType: 'cancelbill',
        username: 'vtec',
        password: 'vtecsystem'
        // username: usernameCancel,
        // password: passwordCancel,
        );
    authInfoModel = await DetectMenuFunc().detectAuthInfo(context, response);
  }

  Future holdBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.holdBill(
        langID: '1',
        orderId: transactionModel!.responseObj!.tranData!.orderID,
        customerName: holdBillName,
        customerMobile: holdBillPhone);
    holdBillModel = await DetectMenuFunc().detectHoldBill(context, response);
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
    notifyListeners();
  }

  Future eCouponInquiry(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.eCouponInquiry(
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
    var response = await _menuRepository.eCouponApply(
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
    var response = await _menuRepository.orderSummary(
        orderId: transactionModel!.responseObj!.tranData!.orderID);
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'orderSummary');
    if (apiState == ApiState.COMPLETED) {
      _htmlOrderSummary =
          transactionModel!.responseObj2!.receiptInfo!.receiptHtml;
    }
    notifyListeners();
  }

  Future finalizeBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    String deviceType = await SharedPref().getResponsiveDevice();
    var response = await _menuRepository.finalizeBill(
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'finalizeBill');
    if (apiState == ApiState.COMPLETED) {
      if (deviceType == 'tablet') {
        await LoadingStyle().dialogPayment2(context,
            text: transactionModel!.responseObj!.paymentList!.last.cashChange
                .toString(),
            popUntil: true,
            popToPage: '/homePage');
      } else {
        var homePvd = context.read<HomeProvider>();
        await LoadingStyle().dialogPaymentProcess(context,
            text: transactionModel!.responseObj!.paymentList!.last.cashChange
                .toString(), onPressed: () async {
          LoadingStyle().dialogLoadding(context);
          await homePvd.openTransaction(context).then((value) {
            if (homePvd.apisState == ApiState.COMPLETED) {
              setTranData(tranModel: json.encode(homePvd.openTranModel))
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/menuPage', (route) => false);
              });
            }
          });
        });
      }
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

  Future productAdd(BuildContext context, double count) async {
    try {
      productObjModel!.responseObj!.productData!.productQty = count;
      apiState = ApiState.LOADING;
      var response = await _menuRepository.productAdd(
          prodObj: json.encode(productObjModel!.responseObj));
      transactionModel = await DetectMenuFunc()
          .detectTransaction(context, response, 'productAdd');
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }
  }

  Future orderProcess(
    BuildContext context,
    double count,
    String editOrderId,
    String modifyId,
    String productId,
  ) async {
    LoadingStyle().dialogLoadding(context);
    String deviceType = await SharedPref().getResponsiveDevice();
    try {
      apiState = ApiState.LOADING;
      var response = await _menuRepository.orderProcess(
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
        LoadingStyle().dialogError(context,
            error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
      } else {
        LoadingStyle().dialogError(context,
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
    var response = await _menuRepository.productObj(
        tranData: json.encode(transactionModel!.responseObj!.tranData),
        productId: prodId.toString(),
        orderDetailId: orderDetailId);
    productObjModel =
        await DetectMenuFunc().detectProductObj(context, response);
  }

  Future cancelTransaction(BuildContext context) async {
    await clearApplyCoupon(context);
    apiState = ApiState.LOADING;
    var response = await _menuRepository.cancelTran(
        langId: '1',
        orderId: transactionModel!.responseObj!.orderID,
        reasonIDList: valueIdReason.text,
        reasonText: reasonTextController.text,
        staffId: authInfoModel!.responseObj!.staffInfo!.staffID.toString());
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
        langId: '1', reasonId: reasonGroupList![index].iD.toString());
    reasonModel = await DetectMenuFunc().detectReason(context, response);
    notifyListeners();
  }

  Future memberData(BuildContext context, String phone) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberData(phoneMember: phone);
    memberDataModel =
        await DetectMenuFunc().detectMemberData(context, response);
  }

  Future memberApply(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberApply(
      memberId: memberDataModel!.responseObj!.memberInfo!.memberID.toString(),
      tranData: json.encode(transactionModel!.responseObj!.tranData),
    );
    transactionModel = await DetectMenuFunc()
        .detectTransaction(context, response, 'memberApply');
  }

  Future memberCancel(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberCancel(
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
        ReadFileFunc().readCurrencyInfo()
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

  setWhereMenu(String value) {
    _valueMenuSelect = int.parse(value);
    prodToShow = prodList!
        .where((e) => e.productGroupID.toString().contains(value))
        .toList();
    notifyListeners();
  }

  Future showFavList(BuildContext context, int pageGroup) async {
    _valueFavGroup = pageGroup;
    favResultList = [];
    await ManageFav1Func().showData(context, pageGroup);
    notifyListeners();
  }

  checkPaymentTab(BuildContext context) {
    _tabController!.addListener(() async {
      switch (_tabController!.index) {
        case 5:
          if (transactionModel!.responseObj!.orderList!.isEmpty) {
            await LoadingStyle().dialogError(context,
                error: LocaleKeys.must_have_at_least_1_order.tr(),
                isPopUntil: true,
                popToPage: '/menuPage');
            setTabToPayment(0);
          }
          break;
        case 1:
          var result =
              favoriteGroupList!.where((element) => element.pageType == 0);
          showFavList(context, result.first.pageIndex!);
          break;
        case 2:
          var result =
              favoriteGroupList!.where((element) => element.pageType == 1);
          showFavList(context, result.first.pageIndex!);
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

  // --------------------------- SET ---------------------------\

  setValueTitle(int value) {
    _valueTitleSelect = value;
    notifyListeners();
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

  setExceptionText(String value) {
    _exceptionText = value;
    notifyListeners();
  }

  Future setTranData({String? tranModel}) async {
    transactionModel = TransactionModel.fromJson(jsonDecode(tranModel!));
  }

  setCouponCodeControllerForTest() {
    couponCodeController.text = '8F811112C4E72E72E177';
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
