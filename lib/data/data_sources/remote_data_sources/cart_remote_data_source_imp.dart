import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/api/api_manager.dart';

import 'package:sahl_shop/core/errors/errors.dart';

import 'package:sahl_shop/domain/entities/GetCartResponseEntity.dart';
import 'package:sahl_shop/domain/entities/OrderResponseEntity.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/api/end_points.dart';
import '../../../core/cache/shared_preference.dart';
import '../../../domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart';
import '../../models/GetCartResponseDm.dart';
import '../../models/OrderResponseDm.dart';
@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImp extends CartRemoteDataSource {
  ApiManager apiManager;
  CartRemoteDataSourceImp({required this.apiManager});
  @override
  Future<Either<Errors, GetCartResponseDm>> getItemInCart()async {

    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var token= await SharedPreference.getData(key: 'token');
        var response=await apiManager.getData(endPoint: EndPoints.getToCart, url: ApiConstants.baseUrl,headers:{'token': token} );
        var getCartResponse=GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(getCartResponse);
        } else {
          return Left(ServerError(errorMessage: getCartResponse.Message!));
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
  Future<Either<Errors, GetCartResponseDm>> deleteItemInCart(String productId)async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var token= await SharedPreference.getData(key: 'token');
        var response=await apiManager.deleteData(endPoint: "${EndPoints.getToCart}/$productId", url: ApiConstants.baseUrl,headers:{'token': token} );
        var deleteCartResponse=GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(deleteCartResponse);
        } else {
          return Left(ServerError(errorMessage: deleteCartResponse.Message!));
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
  Future<Either<Errors, GetCartResponseDm>> updateCountInCart(String productId, int count)async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var token= await SharedPreference.getData(key: 'token');
        var response=await apiManager.updateData(endPoint: "${EndPoints.getToCart}/$productId",body: {
          'count':"$count"
        }, url: ApiConstants.baseUrl,headers:{'token': token} );
        var updateCartResponse=GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(updateCartResponse);
        } else {
          return Left(ServerError(errorMessage: updateCartResponse.Message!));
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
  Future<Either<Errors, OrderResponseDm>> createOrder({required String cartId, required String details, required String phone, required String city})async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var token= await SharedPreference.getData(key: 'token');

        var response=await apiManager.postData(endPoint: EndPoints.order(cartId), url: ApiConstants.baseUrl,headers:{'token': token},body: {

          "shippingAddress": {
            'details':details,
            'phone':phone,
            'city':city
          }

        });
        var orderResponse=OrderResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(orderResponse);
        } else {
          return Left(ServerError(errorMessage: orderResponse.message!));
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
}

