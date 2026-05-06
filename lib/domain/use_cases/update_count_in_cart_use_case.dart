import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/cart/cart_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/GetCartResponseEntity.dart';
@injectable
class UpdateCountInCartUseCase {
  CartRepository cartRepository;
  UpdateCountInCartUseCase({required this.cartRepository});

  Future<Either<Errors, GetCartResponseEntity>>invoke(String productId,int count){
    return cartRepository.updateCountInCart(productId,count);

  }
}