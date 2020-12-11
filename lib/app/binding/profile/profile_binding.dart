import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/data/network/repositories/proflie_repository.dart';
import 'package:flutter_base/domain/interfaces/proflie_interfaces.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileInterface>(() => ProfileRepository(dio: Get.find()));
    Get.lazyPut(() => ProfileController(profileInterface: Get.find()));
  }
}
