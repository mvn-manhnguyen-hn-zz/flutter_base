import 'package:flutter_base/app/page/bill/bill_controller.dart';
import 'package:get/get.dart';

class BillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BillController());
  }
}
