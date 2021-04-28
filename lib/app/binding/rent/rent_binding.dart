import 'package:flutter_base/app/page/rent/rent_controller.dart';
import 'package:get/get.dart';

class RentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RentController());
  }
}
