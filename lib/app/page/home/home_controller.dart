import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/data/network/repositories/shop_repository.dart';
import 'package:flutter_base/domain/entities/error_model.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';
import 'package:get/get.dart';


class HomeController extends Controller {
  HomeController({@required this.shopRepository});

  /// inject repo abstraction dependency
  final ShopRepository shopRepository;

  /// create a reactive status from request with initial value = loading

  final listShop = List<ShopModel>().obs;

  Future<void> fetchListShop({VoidCallback callback}) async {
    status(Status.loading);

    shopRepository.getListShop().then(
      (data) {
        listShop.clear();
        listShop.addAll(data);
        status(Status.success);

        callback?.call();
      },
      onError: (err) {
        if(err is ErrorModel){
          // TODO: callbackError
        }
        status(Status.error);
      },
    );
  }

  @override
  void onConnected() {
    super.onConnected();
  }
}
