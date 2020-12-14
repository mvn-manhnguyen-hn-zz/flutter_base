import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/data/network/providers/shop_providers.dart';
import 'package:flutter_base/data/network/repositories/shop_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopRepository>(() => ShopProviders(networkManager: Get.find()));
    Get.lazyPut(() => HomeController(shopRepository: Get.find()));
  }
}
