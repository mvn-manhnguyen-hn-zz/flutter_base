import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_base/data/network/api_constant.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/setting_model.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:flutter_base/domain/interfaces/shop_interfaces.dart';

class OrderRepository implements OrderInterface {
  final Dio dio;

  OrderRepository({this.dio});

  @override
  Future<ProfileModel> getProfileCustomer() async {
    Completer<ProfileModel> completer = new Completer();
    try {
      final response = await dio.get(ApiConstant.PROFILE,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      print("1111111111111${response.data}");
      print("1111111111111${ProfileModel.fromJson(response.data)}");

      //   completer.complete((response.data as List)
      //      .map((e) => ProfileModel.fromJson(e))
      //.toList());
      completer.complete(ProfileModel.fromJson(response.data));
    } on DioError catch (e) {
      completer.completeError(e.response.data);
      //return Future.error(e.response.data);
    }
    return completer.future;
  }

  @override
  Future<setting> getSettings() async {
    Completer<setting> completer = new Completer();
    try {
      final response = await dio.get(ApiConstant.SETTINGS,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      completer.complete(setting.fromJson(response.data));
    } on DioError catch (e) {
      print(e.toString());
      completer.completeError(e.response.data);
    }
    return completer.future;
  }
}
