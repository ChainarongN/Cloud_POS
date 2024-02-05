class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://apicore.vtec-system.com";
  static const String authUrl = "https://auth.vtec-system.com/connect/token";

  static const String coreDataInit = "$baseUrl/api/POSModule/POS_Init";
  static const String login = "$baseUrl/api/POSModule/POS_StaffLogin";
  static const String startProcess = "$baseUrl/api/POSModule/POS_StartProcess";
  static const String openSession = "$baseUrl/api/POSModule/POS_OpenSession";
  static const String openTran = "$baseUrl/api/POSModule/POS_TranOpen";
}
