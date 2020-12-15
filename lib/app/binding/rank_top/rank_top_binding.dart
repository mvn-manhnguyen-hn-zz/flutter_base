import 'package:flutter_base/app/page/rank_top/rank_top_controller.dart';
import 'package:flutter_base/data/network/repositories/rank_top_repository.dart';
import 'package:flutter_base/domain/interfaces/rank_top_interface.dart';
import 'package:get/get.dart';

class RankTopBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RankTopInterface>(() => RankTopRepository(dio: Get.find()));
    Get.lazyPut(() => RankTopController(rankTopInterface: Get.find()));
  }
}
