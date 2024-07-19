import 'package:flutter/material.dart';

abstract class ILoginRepository {
  Future authToken({String? clientID, String? clientSecret});
  Future login(BuildContext context,
      {String? langId, String? username, String? password});
  Future getCoreDataDetail(BuildContext context, {String? langID});
  Future startProcess(BuildContext context, {String? langID});
  Future openSession(BuildContext context,
      {String? langID, String? openAmount});
}
