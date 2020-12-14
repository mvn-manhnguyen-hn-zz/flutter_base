import 'package:dio/dio.dart';
import 'package:flutter_base/data/network/api_constant.dart';
import 'package:flutter_base/data/network/network_manager.dart';
import 'package:flutter_base/data/network/repositories/shop_repository.dart';
import 'package:flutter_base/domain/entities/shop_model.dart';

class ShopProviders implements ShopRepository {
  final NetworkManagerInterFace networkManager;

  ShopProviders({this.networkManager});

  @override
  Future<List<ShopModel>> getListShop() async{
    try {
      final response = await networkManager.requestApi(
          path: ApiConstant.SHOPS, method: HttpMethodConstant.GET,usingUserToken: true);
      return (response.data as List).map((e) => ShopModel.fromJson(e)).toList();
    } on DioError catch (e) {
      return Future.error(e.response.data);
    }
  }
}