import 'package:flutter/material.dart';

abstract class IUtilityRepository {
  Future closeSession(BuildContext context,
      {String? langId, String? closeSSAmount, String? sessionId});
  Future endDay(
    BuildContext context,
  );
  Future sessionSearch(BuildContext context, {String? langId});
}
