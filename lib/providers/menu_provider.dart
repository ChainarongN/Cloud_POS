// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:cloud_pos/models/cencel_tran_model.dart';
import 'package:cloud_pos/models/code_init_model.dart';
import 'package:cloud_pos/models/coupon_apply_model.dart';
import 'package:cloud_pos/models/coupon_inquiry_model.dart';
import 'package:cloud_pos/models/finalize_bill_model.dart';
import 'package:cloud_pos/models/member_apply_model.dart';
import 'package:cloud_pos/models/member_cancel_model.dart';
import 'package:cloud_pos/models/member_data_model.dart';
import 'package:cloud_pos/models/order_summary_model.dart';
import 'package:cloud_pos/models/pay_amount_model.dart';
import 'package:cloud_pos/models/payment_submit_model.dart';
import 'package:cloud_pos/models/product_add_model.dart';
import 'package:cloud_pos/models/product_obj_model.dart';
import 'package:cloud_pos/models/promotion_cancel_model.dart';
import 'package:cloud_pos/models/reason_model.dart';
import 'package:cloud_pos/networks/api_service.dart';
import 'package:cloud_pos/pages/menu/functions/add_product_func.dart';
import 'package:cloud_pos/pages/menu/functions/detect_menu_func.dart';
import 'package:cloud_pos/pages/menu/functions/manage_fav_func.dart';
import 'package:cloud_pos/pages/menu/functions/payment_func.dart';
import 'package:cloud_pos/pages/menu/functions/read_file_func.dart';
import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/loading_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../repositorys/repository.dart';

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
  List<PayAmountModel>? payAmountList = [];
  List<int>? _selectDiscountList = [];
  ReasonModel? reasonModel;
  CancelTranModel? cancelTranModel;
  ProductObjModel? productObjModel;
  PromotionCancelModel? promotionCancelModel;
  ProductAddModel? productAddModel;
  CouponApplyModel? couponApplyModel;
  CouponInquiryModel? couponInquiryModel;
  PaymentSubmitModel? paymentSubmitModel;
  OrderSummaryModel? orderSummaryModel;
  MemberDataModel? memberDataModel;
  MemberApplyModel? memberApplyModel;
  MemberCancelModel? memberCancelModel;
  FinalizeBillModel? finalizeBillModel;
  int? _valueMenuSelect, _valueCurrencyId, _tranId, _valueFavGroup;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _orderId,
      _tranKey,
      _tranDataCurrent,
      _valueCurrency;
  String _exceptionText = '', _saleModeName = '';
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
  final TextEditingController dueCreditController = TextEditingController();
  TabController? _tabController;
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController couponCodeController = TextEditingController();

  // --------------------------- GET ---------------------------
  bool get getLoading => _isLoading;
  TabController get getTabController => _tabController!;
  String get getOrderId => _orderId!;
  String get getExceptionText => _exceptionText;
  int get getValueFavGroup => _valueFavGroup!;
  String get getSaleModeName => _saleModeName;
  int get getvalueMenuSelect => _valueMenuSelect!;
  String get getvalueReasonGroupSelect => _valueReasonGroupSelect!;
  String get getHtmlOrderSummary => _htmlOrderSummary!;
  String get getValueCurrency => _valueCurrency!;
  int get getValueCurrencyId => _valueCurrencyId!;
  List<int> get getSelectDiscountList => _selectDiscountList!;
  String get getDueAmountCurrent =>
      jsonDecode(_tranDataCurrent!)['DueAmount'].toString();

  // ------------------------ Call Data -------------------------
  init(BuildContext context, TickerProvider tabThis) async {
    _isLoading = true;
    payAmountController.text = '';
    totalPayListController.text = '0.00';
    _tabController = TabController(length: 6, vsync: tabThis);
    _valueCurrency = 'THB';
    _valueCurrencyId = 1;
    productAddModel = null;
    prodGroupList = [];
    prodList = [];
    prodToSearch = [];
    payAmountList = [];
    _selectDiscountList = [];

    await _readData();
    await setReason(context, 0);
    setWhereMenu(prodGroupList![0].productGroupID.toString());
    showFavList(context, favoriteData!.first.pageIndex!);

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
      if (int.parse(payAmount!) < double.parse(getDueAmountCurrent)) {
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

  Future managePayAmountList(BuildContext context, String frag,
      {String? payName,
      String? payCode,
      int? payTypeId,
      String? price,
      int? indexForRemove,
      String? payRemark}) async {
    switch (frag) {
      case 'add':
        payAmountList!.add(
          PayAmountModel(
              payTypeId: payTypeId,
              payCode: payCode,
              payName: payName,
              price: double.parse(price!),
              payRemark: payRemark ?? ''),
        );
        payAmountController.text = '';
        break;
      case 'remove':
        payAmountList!.removeAt(indexForRemove!);
        break;
      case 'clear':
        payAmountList = [];
        break;
    }
    num sum = 0;
    sum = payAmountList!
        .map((e) => e.price)
        .reduce((value, element) => value! + element!)!;
    dueCreditController.text =
        (double.parse(getDueAmountCurrent) - sum).toString();
    totalPayListController.text = sum.toString();
    if (sum >= double.parse(getDueAmountCurrent)) {
      LoadingStyle().dialogLoadding(context);
      await PaymentFunc().paymentMulti(context);
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
        tranKey: _tranKey,
        transactionID: _tranId);
    couponInquiryModel =
        await DetectMenuFunc().detectCouponInquiry(context, response);
  }

  Future eCouponApply(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.eCouponApply(
        langID: '1',
        couponSN: couponInquiryModel!.responseObj!.voucherSN,
        tranData: _tranDataCurrent);
    couponApplyModel =
        await DetectMenuFunc().detectCouponApply(context, response);
    if (apiState == ApiState.COMPLETED) {
      _tranDataCurrent = json.encode(couponApplyModel!.responseObj!.tranData);
    }
    notifyListeners();
  }

  Future promotionCancel(
      BuildContext context, int indexOutside, int indexInside) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.promotionCancel(
      langID: '1',
      promoUUID: couponApplyModel!.responseObj!.promoList![indexOutside]
          .couponList![indexInside].promoUUID,
      tranData: _tranDataCurrent,
    );
    promotionCancelModel =
        await DetectMenuFunc().detectPromotionCancel(context, response);
    if (apiState == ApiState.COMPLETED) {
      couponApplyModel = CouponApplyModel.fromJson(jsonDecode(response));
      _tranDataCurrent =
          json.encode(promotionCancelModel!.responseObj!.tranData);
    }
    notifyListeners();
  }

  Future orderSummary(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.orderSummary(orderId: _orderId);
    orderSummaryModel =
        await DetectMenuFunc().detectOrderSummary(context, response);
    if (apiState == ApiState.COMPLETED) {
      _tranDataCurrent = json.encode(orderSummaryModel!.responseObj!.tranData);
      _htmlOrderSummary =
          orderSummaryModel!.responseObj2!.receiptInfo!.receiptHtml;
    }
    notifyListeners();
  }

  Future finalizeBill(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.finalizeBill(
      tranData: _tranDataCurrent,
    );
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
        payAmount: payAmount,
        tranData: _tranDataCurrent,
        payCode: payCode, //CS
        payName: payName, //Cash
        currencyCode: _valueCurrency, //THB
        payTypeId: payTypeId, //1
        currencyID: _valueCurrencyId,
        payRemark: payRemark ?? '');

    paymentSubmitModel =
        await DetectMenuFunc().detectPaymentSubmit(context, response);
    if (apiState == ApiState.COMPLETED) {
      _tranDataCurrent = json.encode(paymentSubmitModel!.responseObj!.tranData);
    }
  }

  Future productAdd(BuildContext context, double count) async {
    try {
      productObjModel!.responseObj!.productData!.productQty = count;
      apiState = ApiState.LOADING;
      var response = await _menuRepository.productAdd(
          prodObj: json.encode(productObjModel!.responseObj));
      productAddModel =
          await DetectMenuFunc().detectProductAdd(context, response);
      if (apiState == ApiState.COMPLETED) {
        _tranDataCurrent = json.encode(productAddModel!.responseObj!.tranData);
        couponApplyModel = CouponApplyModel.fromJson(jsonDecode(response));
      }
    } catch (e, strack) {
      apiState = ApiState.ERROR;
      Constants().printError(strack.toString());
      LoadingStyle().dialogError(context,
          error: e.toString(), isPopUntil: true, popToPage: '/menuPage');
    }
  }

  Future productObj(
      BuildContext context, int prodId, String orderDetailId) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.productObj(
        tranData: _tranDataCurrent,
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
        orderId: _orderId,
        reasonIDList: valueIdReason.text,
        reasonText: reasonTextController.text);
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
      tranData: _tranDataCurrent,
    );
    memberApplyModel =
        await DetectMenuFunc().detectMemberApply(context, response);
    if (apiState == ApiState.COMPLETED) {
      _tranDataCurrent = json.encode(memberApplyModel!.responseObj!.tranData);
    }
  }

  Future memberCancel(BuildContext context) async {
    apiState = ApiState.LOADING;
    var response = await _menuRepository.memberCancel(
      tranData: _tranDataCurrent,
    );
    memberCancelModel =
        await DetectMenuFunc().detectMemberCancel(context, response);
    if (apiState == ApiState.COMPLETED) {
      _tranDataCurrent = json.encode(memberCancelModel!.responseObj!.tranData);
    }
  }

  Future addReasonText(int index) async {
    if (reasonController.text == '' && valueIdReason.text == '') {
      reasonController.text = reasonModel!.responseObj![index].text!;
      valueIdReason.text = reasonModel!.responseObj![index].iD!.toString();
    } else {
      reasonController.text += ', ${reasonModel!.responseObj![index].text!}';
      valueIdReason.text +=
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
      switch (_tabController!.index) {
        case 5:
          if (productAddModel == null ||
              productAddModel!.responseObj!.orderList!.isEmpty) {
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
    result = couponApplyModel!.responseObj!.orderList![index].promoItemList!
        .map((item) => item.totalDiscount)
        .reduce((a, b) => a! + b!)!;
    if (frag == 'salesPrice') {
      result = couponApplyModel!.responseObj!.orderList![index].retailPrice! -
          result;
    }
    return result.toString();
  }

  Future clearApplyCoupon(BuildContext context) async {
    if (couponApplyModel != null &&
        couponApplyModel!.responseObj!.promoList!.isNotEmpty) {
      var promoList = couponApplyModel!.responseObj!.promoList;
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

  Future showFavList(BuildContext context, int pageGroup) async {
    _valueFavGroup = pageGroup;
    favResultList = [];
    await ManageFav1Func().showData(context, pageGroup);
    notifyListeners();
  }

  // --------------------------- SET ---------------------------\
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
        double.parse(valueQtyOrderController.text);
    await addProductToList(
        context,
        productAddModel!.responseObj!.orderList![index].productID!,
        productAddModel!.responseObj!.orderList![index].qty!,
        productAddModel!.responseObj!.orderList![index].orderDetailID
            .toString());
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

  Future setTranData({
    String? tranObject,
    String? orderID,
    String? saleModeName,
    int? tranId,
    String? tranKey,
  }) async {
    _tranDataCurrent = tranObject;
    _orderId = orderID;
    _saleModeName = saleModeName!;
    _tranId = tranId;
    _tranKey = tranKey;
    couponApplyModel = null;
  }

  setCouponCodeControllerForTest() {
    couponCodeController.text = '111E2F4F09122E72E123';
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
