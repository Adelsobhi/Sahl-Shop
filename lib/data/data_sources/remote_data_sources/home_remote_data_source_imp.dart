import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/api/api_manager.dart';
import 'package:sahl_shop/core/cache/shared_preference.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/data/models/CategoryOrBrandResponseDm.dart';
import 'package:sahl_shop/domain/entities/AddCartResponseEntity.dart';
import 'package:sahl_shop/domain/entities/ProductResponseEntity.dart';
import 'package:sahl_shop/domain/entities/SubCategoryResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/api/end_points.dart';
import '../../models/AddCartResponseDm.dart';
import '../../models/ProductResponseDm.dart';
import '../../models/SubCategoryResponseDm.dart';
@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp extends HomeRemoteDataSource {
  ApiManager apiManager ;
  HomeRemoteDataSourceImp({required this.apiManager});
  @override
  Future<Either<Errors, CategoryOrBrandResponseDm>> getAllCategories() async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var response = await apiManager.getData(
            endPoint: EndPoints.category, url: ApiConstants.baseUrl,
        );

        var categoryResponse = CategoryOrBrandResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(categoryResponse);
        } else {
          return Left(ServerError(errorMessage: categoryResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return
        Left(ServerError(errorMessage: e.toString()));

    }
  }

  @override
  Future<Either<Errors, CategoryOrBrandResponseDm>> getAllBrand() async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var response = await apiManager.getData(
          endPoint: EndPoints.brand, url: ApiConstants.baseUrl,
        );

        var brandResponse = CategoryOrBrandResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(brandResponse);
        } else {
          return Left(ServerError(errorMessage: brandResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return
        Left(ServerError(errorMessage: e.toString()));

    }

  }

  @override
  Future<Either<Errors, ProductResponseDm>> getAllProducts() async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var response = await apiManager.getData(
          endPoint: EndPoints.product, url: ApiConstants.baseUrl,
        );

        var productResponse = ProductResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(productResponse);
        } else {
          return Left(ServerError(errorMessage: productResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return
        Left(Errors(errorMessage: e.toString()));

    }

  }

  @override
  Future<Either<Errors, AddCartResponseDm>> addToCart(String productId) async{

    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var token= await SharedPreference.getData(key: 'token');
        var response=await apiManager.postData(endPoint: EndPoints.addToCart, url: ApiConstants.baseUrl,
            body: {
          "productId":productId,
        },headers:{'token': token} );
        var addCartResponse=AddCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(addCartResponse);
        } else {
          return Left(ServerError(errorMessage: addCartResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return
        Left(ServerError(errorMessage: e.toString()));

    }




  }
///https://ecommerce.routemisr.com/api/v1/categories/6407ea3d5bbc6e43516931df/subcategories
  @override
  // Future<Either<Errors, SubCategoryResponseDm>> getSubCategory(String categoryId) async{
  //   try {
  //     final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult.contains(ConnectivityResult.wifi) ||
  //         connectivityResult.contains(ConnectivityResult.mobile)) {
  //       //todo internet
  //       var response = await apiManager.getSubCategory(
  //         endPoint: EndPoints.subCategory(categoryId),
  //       );
  //
  //       var subCategoryResponse = SubCategoryResponseDm.fromJson(response.data);
  //       if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //         return Right(subCategoryResponse);
  //       } else {
  //         return Left(ServerError(errorMessage: subCategoryResponse.message!));
  //       }
  //     } else {
  //       //todo no internet
  //       return Left(NetworkError(
  //           errorMessage: 'no internet connection please check internet'));
  //     }
  //   }catch(e){
  //     return
  //       Left(Errors(errorMessage: e.toString()));
  //
  //   }
  // }

  Future<Either<Errors, SubCategoryResponseDm>> getSubCategory(String categoryId) async {
    try {

      print("🔥 categoryId = $categoryId");
      print("🔥 URL = ${ApiConstants.baseUrl}${EndPoints.subCategory(categoryId)}");

      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {

        var response = await apiManager.getSubCategory(
          endPoint: EndPoints.subCategory(categoryId),
        );

        print("🔥 RESPONSE DATA = ${response.data}");

        var subCategoryResponse =
        SubCategoryResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(subCategoryResponse);
        } else {
          return Left(ServerError(errorMessage: subCategoryResponse.message!));
        }
      } else {
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    } catch (e) {
      return Left(Errors(errorMessage: e.toString()));
    }
  }


}