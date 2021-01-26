import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import '../api_constant.dart';

class OrderRepository implements OrderInterface{
  final Dio dio;
  OrderRepository({@required this.dio});
  @override
  Future<ProfileModel> getInformation() async {
    try {
      final response = await dio.get(ApiConstant.PROFILE,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      return ProfileModel.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response.data);
    }
  }
  @override
  Future<List<String>> getPaymentMethods() async {
    try {
      final response = await dio.get(ApiConstant.SETTINGS,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      final List<String> list = [];
      (response.data['payment_methods'] as Map).forEach((key, value) {
        list.add(value);
      });
    return list;
    } on DioError catch (e) {
    return Future.error(e.response.data);
    }
  }
}
