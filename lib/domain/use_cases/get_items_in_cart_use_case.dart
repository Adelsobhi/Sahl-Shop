import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/cart/cart_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/GetCartResponseEntity.dart';
@injectable
class GetItemsInCartUseCase {
  CartRepository cartRepository;
  GetItemsInCartUseCase({required this.cartRepository});

  Future<Either<Errors, GetCartResponseEntity>>invoke(){
    return cartRepository.getItemInCart();

  }
}