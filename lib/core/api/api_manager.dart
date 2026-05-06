import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/api/end_points.dart';

import 'api_constants.dart';

/*  https://ecommerce.routemisr.com/api/v1/auth/signup */
@singleton
class ApiManager {





 final dio=Dio();
 Future<Response> getData({
   required String endPoint,
   required String
   url,Map<String, dynamic>? queryParameters,Options? options,Map<String, dynamic>?headers}){
 return dio.get(url+endPoint,queryParameters: queryParameters, options: Options(
     validateStatus: (stats)=> true,
     headers: headers
 ));
 }

 //////
 //https://ecommerce.routemisr.com/api/v1/categories/6407ea3d5bbc6e43516931df/subcategories
 // Future<Response> getSubCategory({
 //   required String endPoint,required String endPoint2,
 //   required String url,Map<String, dynamic>? queryParameters,Options? options,Map<String, dynamic>?headers}){
 //   return dio.get(url+endPoint+'/'+endPoint2 +'/subcategories',queryParameters: queryParameters, options: Options(
 //       validateStatus: (stats)=> true,
 //       headers: headers
 //   ));
 // }

 Future<Response> getSubCategory({
   required String endPoint,
   Map<String, dynamic>? queryParameters,
   Options? options,
   Map<String, dynamic>? headers,
 }) {
   return dio.get(ApiConstants.baseUrl+endPoint
     ,
     queryParameters: queryParameters,
     options: Options(
       validateStatus: (status) => true,
       headers: headers,
     ),
   );
 }







 Future<Response> postData({required String endPoint,required String url,Map<String, dynamic>? queryParameters,Options? options,Object? body,Map<String, dynamic>?headers}){
   return dio.post(url+endPoint,queryParameters: queryParameters, options: Options(
     validateStatus: (stats)=> true,
         headers: headers
   ),data: body);
 }



 Future<Response> deleteData({required String endPoint,required String url,Map<String, dynamic>? queryParameters,Options? options,Object? body,Map<String, dynamic>?headers}){
   return dio.delete(url+endPoint,queryParameters: queryParameters, options: Options(
       validateStatus: (stats)=> true,
       headers: headers
   ),data: body);
 }



 Future<Response> updateData({required String endPoint,required String url,Map<String, dynamic>? queryParameters,Options? options,Object? body,Map<String, dynamic>?headers}){
   return dio.put(url+endPoint,queryParameters: queryParameters, options: Options(
       validateStatus: (stats)=> true,
       headers: headers
   ),data: body);
 }



}