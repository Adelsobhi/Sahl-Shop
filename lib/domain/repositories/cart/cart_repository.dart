import 'package:dartz/dartz.dart';
import 'package:sahl_shop/domain/entities/GetCartResponseEntity.dart';

import '../../../core/errors/errors.dart';
import '../../entities/OrderResponseEntity.dart';

abstract class CartRepository {
  Future<Either<Errors,GetCartResponseEntity>>getItemInCart();
  Future<Either<Errors,GetCartResponseEntity>>deleteItemInCart(String productId);
  Future<Either<Errors,GetCartResponseEntity>>updateCountInCart(String productId,int count);
  Future<Either<Errors, OrderResponseEntity>> createOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  });

}