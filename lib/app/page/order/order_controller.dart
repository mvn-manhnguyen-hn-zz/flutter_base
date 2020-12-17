import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:get/get.dart';
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
   getWidget({
    @required List<String> list,
    @required RxString selectedValue,
    @required RxBool show
  }) {
    Get.bottomSheet(
        Container(
          width: double.infinity,
          color: white,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index){
                return Obx(() => radioListTitle(
                    value: list[index],
                    groupValue: selectedValue.value,
                    onChange: (value) async {
                      selectedValue(value);
                      await Future.delayed(Duration(seconds: 2));
                      show(true);
                      Get.back();
                    }
                ));
              }
          ),
        )
    );
  }
}
