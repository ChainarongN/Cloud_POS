// ignore_for_file: use_build_context_synchronously

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
  List<PayTypeInfo>? payTypeInfoList;
  List<Products>? prodList;
  List<Products>? prodToShow;
  List<Products>? prodToSearch;
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
  int? _valueMenuSelect, _valueCurrencyId, _tranId;
  String? _valueReasonGroupSelect,
      _htmlOrderSummary,
      _orderId,
      _tranKey,
      _tranDataCurrent,
      _valueCurrency;
  String _exceptionText = '', _saleModeName = '';

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
  final TextEditingController _phoneMemberController = TextEditingController();
  TabController? _tabController;
  final ScreenshotController _screenshotController = ScreenshotController();
  final TextEditingController _couponCodeController = TextEditingController();

  // --------------------------- GET ---------------------------
  bool get getLoading => _isLoading;
  TabController get getTabController => _tabController!;
  String get getOrderId => _orderId!;
  String get getExceptionText => _exceptionText;
  String get getSaleModeName => _saleModeName;
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
  TextEditingController get getPhoneMemberController => _phoneMemberController;
  TextEditingController get getcouponCodeController => _couponCodeController;
  ScreenshotController get getScreenshotController => _screenshotController;
  List<int> get getSelectDiscountList => _selectDiscountList!;
  String get getDueAmountCurrent =>
      jsonDecode(_tranDataCurrent!)['DueAmount'].toString();

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
    _selectDiscountList = [];
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
        _payAmountController.text = '';
        break;
      case 'remove':
        payAmountList!.removeAt(indexForRemove!);
        break;
      case 'clear':
        payAmountList = [];
        break;
    }
    num sum = 0;
    for (var element in payAmountList!) {
      sum += element.price!;
    }
    _totalPayListController.text = sum.toString();
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
        voucherSN: getcouponCodeController.text,
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
    apiState = ApiState.LOADING;
    var response = await _menuRepository.cancelTran(
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
        ReadFileFunc().readPaymentInfo(),
        ReadFileFunc().readFavoriteGroup(),
        ReadFileFunc().readShopData(),
        ReadFileFunc().readComputerName()
      ]);
      prodGroupList = value[0] as List<ProductGroup>;
      prodList = value[1] as List<Products>;
      reasonGroupList = value[2] as List<ReasonGroup>;
      payTypeInfoList = value[3] as List<PayTypeInfo>;
      favoriteGroupList = value[4] as List<FavoriteGroup>;
      shopData = value[5] as ShopData;
      computerName = value[6] as ComputerName;

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
              error: LocaleKeys.must_have_at_least_1_order.tr(),
              isPopUntil: true,
              popToPage: '/menuPage');
          setTabToPayment(0);
        }
      }
    });
  }

  String sumTotalDiscountCoupon(int index, String frag) {
    double result = 0;
    int indexCount =
        couponApplyModel!.responseObj!.orderList![index].promoItemList!.length;
    for (var i = 0; i < indexCount; i++) {
      result += couponApplyModel!
          .responseObj!.orderList![index].promoItemList![i].totalDiscount!;
    }
    if (frag == 'salesPrice') {
      result = couponApplyModel!.responseObj!.orderList![index].retailPrice! -
          result;
    }
    return result.toString();
  }

  String getWhereCouponId(int promotionId) {
    var data = couponApplyModel!.responseObj!.promoList!
        .where((element) => element.promotionID == promotionId);
    return data.first.couponList!.first.couponNumber!;
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

  Future clearField() async {
    _phoneMemberController.text = '';
    _couponCodeController.text = '';
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

  final List<String> currencyitems = ['THB'];
  setCouponCodeControllerForTest() {
    _couponCodeController.text = '81F0FBC1111C2E72E153';
    notifyListeners();
  }
}
