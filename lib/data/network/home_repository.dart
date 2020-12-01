import 'package:dio/dio.dart';
import 'package:flutter_base/data/api_constant.dart';
import 'package:flutter_base/domain/entities/case_model.dart';
import 'package:flutter_base/domain/interfaces/home_interfaces.dart';

class HomeRepository implements HomeInterface {
  HomeRepository({this.dio});

  final Dio dio;

  @override
  Future<CasesModel> getCases() async {
    try {
      final response = await dio.get(ApiConstant.API_COVID);
      return CasesModel.fromJson(response.data as Map<String, dynamic>);
    } on Exception catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
