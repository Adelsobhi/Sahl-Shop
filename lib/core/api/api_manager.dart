import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_constants.dart';

/*  https://ecommerce.routemisr.com/api/v1/auth/signup */
@singleton
class ApiManager {
 final dio=Dio();
 Future<Response> getData({required String endPoint,required String url,Map<String, dynamic>? queryParameters,Options? options,Map<String, dynamic>?headers}){
 return dio.get(url+endPoint,queryParameters: queryParameters, options: Options(
     validateStatus: (stats)=> true,
     headers: headers
 ));
 }

 Future<Response> postData({required String endPoint,required String url,Map<String, dynamic>? queryParameters,Options? options,Object? body,Map<String, dynamic>?headers}){
   return dio.post(url+endPoint,queryParameters: queryParameters, options: Options(
     validateStatus: (stats)=> true,
         headers: headers
   ),data: body);
 }
}