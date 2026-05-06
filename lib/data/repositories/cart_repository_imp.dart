import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/GetCartResponseEntity.dart';
import 'package:sahl_shop/domain/entities/OrderResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/cart/cart_repository.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart';
@Injectable(as: CartRepository)
class CartRepositoryImp extends CartRepository {
  CartRemoteDataSource cartRemoteDataSource;
  CartRepositoryImp({required this.cartRemoteDataSource});
  @override
  Future<Either<Errors, GetCartResponseEntity>> getItemInCart()async {
    var either = await cartRemoteDataSource.getItemInCart();
    return either.fold((errors)=> Left(errors), (response)=>Right(response));


  }

  @override
  Future<Either<Errors, GetCartResponseEntity>> deleteItemInCart(String productId) async{
    var either = await cartRemoteDataSource.deleteItemInCart(productId);
    return either.fold((errors)=> Left(errors), (response)=>Right(response));
  }

  @override
  Future<Either<Errors, GetCartResponseEntity>> updateCountInCart(String productId, int count) async{
    var either = await cartRemoteDataSource.updateCountInCart(productId,count);
    return either.fold((errors)=> Left(errors), (response)=>Right(response));
  }

  @override
  Future<Either<Errors, OrderResponseEntity>> createOrder({required String cartId, required String details, required String phone, required String city}) async{
    var either = await cartRemoteDataSource.createOrder(cartId: cartId, details: details, phone: phone, city: city);
    return either.fold((errors)=> Left(errors), (response)=>Right(response));
  }
}