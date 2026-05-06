import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/entities/AddCartResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/home/home_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/CategoryOrBrandResponseEntity.dart';
@injectable
class AddToCartUseCase {
  HomeRepository homeRepository;
  AddToCartUseCase({required this.homeRepository});

  Future<Either<Errors,AddCartResponseEntity >>  invoke({required String productId}){
    return homeRepository.addToCart(productId);
 }
}