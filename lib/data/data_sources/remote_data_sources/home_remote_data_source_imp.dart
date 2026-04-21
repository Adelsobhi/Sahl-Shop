import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/api/api_manager.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/data/models/CategoryOrBrandResponseDm.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';

import '../../../core/api/end_points.dart';
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
            endPoint: EndPoints.category,
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
          endPoint: EndPoints.brand,
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

}