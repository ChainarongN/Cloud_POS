class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://apicore.vtec-system.com";
  static const String authUrl = "https://auth.vtec-system.com/connect/token";

  static const String coreDataInit = "$baseUrl/api/POSModule/POS_Init";
  static const String login = "$baseUrl/api/POSModule/POS_StaffLogin";
  static const String startProcess = "$baseUrl/api/POSModule/POS_StartProcess";
  static const String openSession = "$baseUrl/api/POSModule/POS_OpenSession";
  static const String openTran = "$baseUrl/api/POSModule/POS_TranOpen";
  static const String reason = "$baseUrl/api/POSModule/POS_Reason";
  static const String cancelTran = "$baseUrl/api/POSModule/POS_TranVoid";
  static const String closeSession = "$baseUrl/api/POSModule/POS_SessionClose";
  static const String productObj = "$baseUrl/api/POSModule/OrderMenu_Obj";
  static const String productAdd = "$baseUrl/api/POSModule/OrderMenu_AddUpdate";
  static const String paymenySubmit = "$baseUrl/api/POSModule/Payment_Submit";
  static const String endDay = "$baseUrl/api/POSModule/POS_EndDay";
  static const String finalizeBill =
      "$baseUrl/api/POSModule/Order_FinalizeBill";
  static const String orderSummary = "$baseUrl/api/POSModule/POS_OrderSummary";
  static const String sessionSearch =
      "$baseUrl/api/POSModule/POS_SessionSearch";
}
