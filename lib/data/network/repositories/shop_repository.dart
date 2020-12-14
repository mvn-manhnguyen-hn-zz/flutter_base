import 'package:flutter_base/domain/entities/shop_model.dart';

abstract class ShopRepository {
  Future<List<ShopModel>> getListShop();
}
