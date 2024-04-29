class Endpoints {
  Endpoints._();

  // static const String baseUrl = "https://apicore.vtec-system.com";
  static const String authUrl = "https://auth.vtec-system.com/connect/token";

  static const String coreDataInit = "api/POSModule/POS_Init";
  static const String login = "api/POSModule/POS_StaffLogin";
  static const String startProcess = "api/POSModule/POS_StartProcess";
  static const String openSession = "api/POSModule/POS_OpenSession";
  static const String openTran = "api/POSModule/POS_TranOpen";
  static const String reason = "api/POSModule/POS_Reason";
  static const String cancelTran = "api/POSModule/POS_TranVoid";
  static const String closeSession = "api/POSModule/POS_SessionClose";
  static const String productObj = "api/POSModule/OrderMenu_Obj";
  static const String productAdd = "api/POSModule/OrderMenu_AddUpdate";
  static const String paymenySubmit = "api/POSModule/Payment_Submit";
  static const String endDay = "api/POSModule/POS_EndDay";
  static const String finalizeBill = "api/POSModule/Order_FinalizeBill";
  static const String orderSummary = "api/POSModule/POS_OrderSummary";
  static const String sessionSearch = "api/POSModule/POS_SessionSearch";
  static const String memberData = "api/POSModule/Member_Data";
  static const String memberApply = "api/POSModule/Member_Apply";
  static const String memberCancel = "api/POSModule/Member_Cancel";
  static const String eCouponInquiry = "api/POSModule/eCoupon_Inquiry";
  static const String eCouponApply = "api/POSModule/eCoupon_Apply";
  static const String promotionCancel = "api/POSModule/Promotion_Cancel";
  static const String orderProcess = "api/POSModule/POS_OrderProcess";
  static const String authInfo = "api/POSModule/POS_AuthInfo";
  static const String holdBill = "api/POSModule/POS_HoldBill";
  static const String holdBillSearch = "api/POSModule/POS_HoldBillSearch";
  static const String unHoldBill = "api/POSModule/POS_UnHoldBill";
}
