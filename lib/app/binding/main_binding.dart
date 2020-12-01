import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());
  }
}