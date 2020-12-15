import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:flutter_base/domain/interfaces/product_interfaces.dart';
import 'package:get/get.dart';

class ProductController extends Controller {
  ProductController({@required this.productInterface});

  /// inject repo abstraction dependency
  final ProductInterface productInterface;

  /// create a reactive status from request with initial value = loading

  final listProduct = List<ProductModel>().obs;
  final listSelected = List<ProductModel>().obs;
  final listCategory = List<String>().obs;
  var listCheck = List<bool>().obs;
  RxBool check = false.obs;

  Future<void> fetchListProduct({VoidCallback callback}) async {
    status(Status.loading);

    productInterface.getListProduct().then(
      (data) {
        listProduct.clear();
        listProduct.addAll(data);
        status(Status.success);
        //print(status);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  Future<void> fetchListCategory({VoidCallback callback}) async {
    status(Status.loading);

    productInterface.getListCategory().then(
      (data) {
        print(data.toList());
        listCategory.clear();
        listCategory.addAll(data);
        status(Status.success);
        print(status);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
        print("=======" + err.toString());
      },
    );
  }

  addToListSelected(ProductModel item) {
    listSelected.add(item);
  }

  @override
  void onConnected() {
    super.onConnected();
  }
}