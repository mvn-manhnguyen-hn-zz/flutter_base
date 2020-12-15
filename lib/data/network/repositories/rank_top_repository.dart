import 'package:dio/dio.dart';
import 'package:flutter_base/domain/entities/rank_top_model.dart';
import 'package:flutter_base/domain/interfaces/rank_top_interface.dart';
import '../api_constant.dart';

class RankTopRepository implements RankTopInterface{
  final Dio dio;
  RankTopRepository({this.dio});
  @override
  Future<List<Before>> getRankTop() async {
    try {
    final response = await dio.get(ApiConstant.RANKTOP,
    options: await HeaderNetWorkConstant.getOptionsWithToken());
    return (response.data['this'] as List).map((e) => Before.fromJson(e)).toList();
    } on DioError catch (e) {
    return Future.error(e.response.data);
    }
  }
}
