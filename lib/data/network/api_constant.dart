
import 'package:dio/dio.dart';

class ApiConstant{
  static const  BASE_URL = 'https://demo.shopmede.com/api/';

  //API
  static const SHOPS = 'shops';

}

class HttpMethodConstant{
  static const  POST = 'POST';
  static const  GET = 'GET';
  static const  PUT = 'PUT';
  static const  HEAD = 'HEAD';
  static const  DELETE = 'DELETE';
  static const  PATCH = 'PATCH';
}
class HeaderNetWorkConstant {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstant.BASE_URL,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // 'charset': 'utf-8',
        'accept': 'application/json'
      });


}
