import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/cart/cart_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/GetCartResponseEntity.dart';
@injectable
class DeleteItemsInCartUseCase {
  CartRepository cartRepository;
  DeleteItemsInCartUseCase({required this.cartRepository});

  Future<Either<Errors, GetCartResponseEntity>>invoke(String productId){
    return cartRepository.deleteItemInCart(productId);

  }
}