import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/data/network/repositories/proflie_repository.dart';
import 'package:flutter_base/data/network/repositories/rank_top_repository.dart';
import 'package:flutter_base/data/network/repositories/shop_repository.dart';
import 'package:flutter_base/domain/interfaces/proflie_interfaces.dart';
import 'package:flutter_base/domain/interfaces/rank_top_interface.dart';
import 'package:flutter_base/domain/interfaces/shop_interfaces.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopInterface>(() => ShopRepository(dio: Get.find()));
    Get.lazyPut<RankTopInterface>(() => RankTopRepository(dio: Get.find()));
    Get.lazyPut<ProfileInterface>(() => ProfileRepository(dio: Get.find()));
    Get.lazyPut(() => HomeController(
        shopInterface: Get.find(),
        rankTopInterface: Get.find(),
        profileInterface: Get.find(),
    ));
  }
}
