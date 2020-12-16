import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/setting_model.dart';
import 'package:flutter_base/domain/interfaces/order_interface.dart';
import 'package:get/get.dart';
import 'package:flutter_base/domain/entities/product_model.dart';

class OrderController extends Controller {
  OrderController({@required this.orderInterface});
  final radioGroupValue = "".obs;
  final nickValue = "".obs;
  final isVisibleTextfieldNick = false.obs;
  final isVisibleTextfieldSetting = false.obs;

  /// inject repo abstraction dependency
  final OrderInterface orderInterface;

  /// create a reactive status from request with initial value = loading
  final listSelected = List<ProductModel>().obs;
  final listProfileCustomer = List<ProfileModel>().obs;
  final listSetting = List<String>().obs;
  int price = 0;
  Future<void> setRadioGroupValue(val) {
    radioGroupValue(val);
  }

  Future<void> setTextFileValue(val) {
    nickValue(val);
  }

  int getPrice(List<ProductModel> listSelected) {
    for (int i = 0; i < listSelected.length; i++) {
      price += listSelected[i].price;
    }
    return price;
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
