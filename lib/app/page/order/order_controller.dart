import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrderController extends Controller {
  final OrderInterface orderInterface;
  OrderController({@required this.orderInterface});

  final RxBool showAccount = false.obs;
  final RxBool showPaymentMethod = false.obs;
  final RxBool showSelectProduct = false.obs;
  final Rx<List<String>> nicknames = Rx<List<String>>();
  final listPaymentMethods = List<String>().obs;
  final RxString selectedAccount = 'abcXYZdsdsscsewc'.obs;
  final RxString selectedPaymentMethods = 'abcXYZdsdsscsewc'.obs;

  Future<void> fetchInformation({VoidCallback callback}) async {
    status(Status.loading);
    orderInterface.getInformation().then((value) {
      nicknames(value.nicknames);
      status(Status.success);
      callback?.call();
    },
      onError: (err) {
        status(Status.error);
      },
    );
  }
  Future<void> fetchPaymentMethods({VoidCallback callback}) async {
    status(Status.loading);
    orderInterface.getPaymentMethods().then((value) {
      listPaymentMethods(value);
      status(Status.success);
      callback?.call();
    },
      onError: (err) {
        status(Status.error);
      },
    );
  }
}
