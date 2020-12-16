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
  final listProductFromAPI = List<ProductModel>().obs;
  final listSelected = List<ProductModel>().obs;
  final listCategory = List<String>().obs;
  final listSort = List<String>().obs;

  Future<void> fetchListProduct({VoidCallback callback}) async {
    status(Status.loading);

    productInterface.getListProduct().then(
      (data) {
        listProduct.clear();
        listProduct.addAll(data);
        listProductFromAPI.clear();
        listProductFromAPI.addAll(data);

        status(Status.success);
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
        listCategory.clear();
        listCategory.addAll(data);
        status(Status.success);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }

  sortByCategory() {
    if (listSort.length > 0) {
      listProduct.clear();
      listProductFromAPI.forEach((productItem) {
        if (listSort.contains(productItem.categoryName)) {
          listProduct.add(productItem);
        }
      });
    } else {
      listProduct.clear();
      listProduct.addAll(listProductFromAPI);
    }
  }

  addToListSelected(ProductModel item) {
    listSelected.add(item);
  }

  addToListSort(String item) {
    listSort.add(item);
  }

  @override
  void onConnected() {
    super.onConnected();
  }
}
