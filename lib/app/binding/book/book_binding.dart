import 'package:flutter_base/app/page/book/book_controller.dart';
import 'package:get/get.dart';

class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookController());
  }
}
