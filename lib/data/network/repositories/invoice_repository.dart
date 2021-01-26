import 'package:dio/dio.dart';
import 'package:flutter_base/domain/interfaces/invoice_interface.dart';
import '../api_constant.dart';

class InvoiceRepository implements InvoiceInterface{
  final Dio dio;
  const InvoiceRepository({this.dio});

  @override
  Future<dynamic> getInvoice() async {
    try {
      final response = await dio.get(ApiConstant.INVOICE,
          options: await HeaderNetWorkConstant.getOptionsWithToken());
      print(response.data);
      return response.data;
      //return ProfileModel.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response.data);
    }
  }
}
