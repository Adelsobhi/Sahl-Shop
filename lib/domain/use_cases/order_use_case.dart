import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/auth/auth_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/LoginResponseEntity.dart';
import '../entities/OrderResponseEntity.dart';
import '../entities/RegisterResponseEntity.dart';
import '../repositories/cart/cart_repository.dart';
@injectable
class OrderUseCase {
  CartRepository  cartRepository;
  OrderUseCase({required this.cartRepository});




  Future<Either<Errors, OrderResponseEntity>>invoke({
    required String cartId,
    required String details,
    required String phone,
    required String city,}){
    return cartRepository.createOrder(cartId: cartId, details: details, phone: phone, city: city);
  }
  }


