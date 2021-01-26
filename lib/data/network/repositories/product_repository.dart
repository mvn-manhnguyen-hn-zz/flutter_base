import 'package:dio/dio.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:flutter_base/domain/interfaces/product_interface.dart';
import '../api_constant.dart';

class ProductRepository implements ProductInterface {
  final Dio dio;
  const ProductRepository({this.dio});

  @override
  Future<List<ProductModel>> getListProduct() async {
    try {
      final response = await dio.get(ApiConstant.PRODUCT,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      return (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
    } on DioError catch (e){
      return Future.error(e.response.data);
    }
  }

  @override
  Future<List> getListCategory() async {
    try {
      final response = await dio.get(ApiConstant.CATEGORY,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      return response.data;
    } on DioError catch (e){
      return Future.error(e.response.data);
    }
  }
}
