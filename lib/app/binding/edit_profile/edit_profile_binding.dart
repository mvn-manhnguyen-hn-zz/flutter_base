import 'package:flutter_base/app/page/editProfile/edit_profile_controller.dart';
import 'package:flutter_base/data/network/repositories/edit_profile_repository.dart';
import 'package:flutter_base/domain/interfaces/edit_profile_interface.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditProfileInterface>(() => EditProfileRepository(dio: Get.find()));
    Get.lazyPut(() => EditProfileController(editProfileInterface: Get.find()));
  }
}
