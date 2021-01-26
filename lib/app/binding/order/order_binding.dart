import 'package:flutter_base/app/page/order/order_controller.dart';
import 'package:flutter_base/data/network/repositories/order_repository.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:get/get.dart';

class OrderBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OrderInterface>(() => OrderRepository(dio: Get.find()));
    Get.lazyPut(() => OrderController(orderInterface: Get.find()));
  }
}
