import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';
import 'package:flutter_base/domain/interfaces/shop_interfaces.dart';
import 'package:get/get.dart';


class HomeController extends Controller {
  HomeController({@required this.shopInterface});

  /// inject repo abstraction dependency
  final ShopInterface shopInterface;

  /// create a reactive status from request with initial value = loading

  final listShop = List<ShopModel>().obs;

  Future<void> fetchListShop({VoidCallback callback}) async {
    status(Status.loading);

     shopInterface.getListShop().then(
      (data) {
        listShop.clear();
        listShop.addAll(data);
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
