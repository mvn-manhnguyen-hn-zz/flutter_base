import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/category_model.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:flutter_base/domain/interfaces/product_interface.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductController extends Controller {
  final ProductInterface productInterface;
  ProductController({this.productInterface});
  final listProduct = List<ProductModel>().obs;
  final listCategory = List<Category>().obs;
  final listProductFilter = List<ProductModel>().obs;
  final listProductChose = List<ProductModel>().obs;

  Future<void> fetchListProduct({Callback callback}) async {
    status(Status.loading);
    productInterface.getListProduct()
        .then((value){
          listProduct.clear();
          listProduct(value);

          status(Status.success);
    })
        .catchError((e) => status(Status.error));
  }

  Future<void> fetchListCategory({Callback callback}) async {
    status(Status.loading);
    productInterface.getListCategory()
        .then((value){
          listCategory.clear();
          value.forEach((element) {
            listCategory.add(
              Category(name: element, isChose: false)
            );
          });
      status(Status.success);
    })
        .catchError((e) => status(Status.error));
  }
}
