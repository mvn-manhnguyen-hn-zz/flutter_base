import 'package:dio/dio.dart';
import 'package:flutter_base/data/network/api_constant.dart';
import 'package:flutter_base/data/network/network_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(HeaderNetWorkConstant.baseOptions));
    Get.lazyPut<NetworkManagerInterFace>(() => NetworkManager(dio: Get.find()));

  }
}
