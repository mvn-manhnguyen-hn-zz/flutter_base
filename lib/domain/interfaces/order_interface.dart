import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/setting_model.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';

abstract class OrderInterface {
  Future<ProfileModel> getProfileCustomer();
  Future<setting> getSettings();
  // Future<ProfileModel> getSettingCustomer();
}
