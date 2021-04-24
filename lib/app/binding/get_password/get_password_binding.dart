import 'package:flutter_base/app/page/get_password/get_password_controller.dart';
import 'package:get/get.dart';

class GetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GetPassWordController());
  }
}
