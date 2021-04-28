import 'package:flutter_base/app/page/parking_lot/parking_lot_controller.dart';
import 'package:get/get.dart';

class ParkingLotBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ParkingLotController());
  }
}
