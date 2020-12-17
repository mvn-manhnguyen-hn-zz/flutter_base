import 'package:flutter_base/domain/entities/profile_model.dart';

abstract class OrderInterface{
  Future<ProfileModel> getInformation();
  Future<List<String>> getPaymentMethods();
}
