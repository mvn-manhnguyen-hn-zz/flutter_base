import 'package:dio/dio.dart';
import 'package:flutter_base/data/network/api_constant.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';
import 'package:flutter_base/domain/interfaces/shop_interfaces.dart';

class ShopRepository implements ShopInterface {
  final Dio dio;

  ShopRepository({this.dio});

  @override
  Future<List<ShopModel>> getListShop() async {
    //print(ApiConstant.SHOPS);
    try {
      final response = await dio.get(ApiConstant.SHOPS,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      // print(dio);
      // print(dio.httpClientAdapter);
      // print(dio.transformer);
      // print('------------');
      // print(response.data);
      // Map<String, dynamic> a = response.data;
      // a.forEach((key, value) {
      //   print(key);
      // });
      // print(response.statusCode);
      // print(response.data);
      // print(response.data);
      // var profile = ProfileModel.fromJson(response.data);
      // print(profile.id);
      // print('ok');
      return (response.data as List).map((e) => ShopModel.fromJson(e)).toList();
    } on DioError catch (e) {
      return Future.error(e.response.data);
    }
  }
}
