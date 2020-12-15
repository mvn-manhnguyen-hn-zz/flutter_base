import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/data/network/api_constant.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:flutter_base/domain/interfaces/product_interfaces.dart';

class ProductRepository implements ProductInterface {
  final Dio dio;

  ProductRepository({this.dio});

  @override
  Future<List<ProductModel>> getListProduct() async {
    try {
      final response = await dio.get(ApiConstant.PRODUCTS,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      //print(e.response.data);
      return Future.error(e.response.data);
    }
  }

  @override
  Future<List<String>> getListCategory() async {
    try {
      final response = await dio.get(ApiConstant.CATEGORY,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      //print(response.data);

      return (response.data as List<dynamic>).map((e) => e.toString()).toList();
    } on DioError catch (e) {
      //print(e.response.data);
      return Future.error(e.response.data);
    }
  }
}
