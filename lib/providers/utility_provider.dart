import 'package:cloud_pos/repositorys/utility/i_utility_repositoty.dart';
import 'package:flutter/material.dart';

class UtilityProvider extends ChangeNotifier {
  final IUtilityRepository _utilityRepository;
  UtilityProvider(this._utilityRepository);
}
