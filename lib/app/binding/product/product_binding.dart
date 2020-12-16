import 'package:flutter_base/app/page/product/product_controller.dart';
import 'package:flutter_base/data/network/repositories/product_repository.dart';
import 'package:flutter_base/domain/interfaces/product_interfaces.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductInterface>(() => ProductRepository(dio: Get.find()));
    Get.lazyPut(() => ProductController(productInterface: Get.find()));
  }
}
