import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/setting_model.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:get/get.dart';

class OrderController extends Controller {
  OrderController({@required this.orderInterface});
  final radioGroupValue = "".obs;
  final nickValue = "".obs;
  final isVisibleTextfieldNick = false.obs;
  final isVisibleTextfieldSetting = false.obs;

  /// inject repo abstraction dependency
  final OrderInterface orderInterface;

  /// create a reactive status from request with initial value = loading

  final listProfileCustomer = List<ProfileModel>().obs;
  final listSetting = List<String>().obs;
  Future<void> setRadioGroupValue(val) {
    radioGroupValue(val);
  }

  Future<void> setTextFileValue(val) {
    nickValue(val);
  }

  Future<void> getSetting() {
    orderInterface.getSettings().then((setting) {
      for (int i = 1; i < 9; i++) {
        listSetting.add(setting.paymentMethods.toJson()["${i}"].toString());
      }
      print("list demo${listSetting}");
    }).catchError((err) => {});
  }

  Future<void> fetchProfileCustomer({VoidCallback callback}) async {
    status(Status.loading);
    print("daaaaaaaa");
    orderInterface.getProfileCustomer().then(
      (data) {
        print("dataaaaaaa${data.toJson()}");

        listProfileCustomer.clear();
        listProfileCustomer.add(data);
        status(Status.success);

        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  @override
  void onConnected() {
    super.onConnected();
  }
}
