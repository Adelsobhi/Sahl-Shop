import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/entities/ProductResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/home/home_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/CategoryOrBrandResponseEntity.dart';
@injectable
class GetAllProductUseCase {
  HomeRepository homeRepository;
  GetAllProductUseCase({required this.homeRepository});

  Future<Either<Errors, ProductResponseEntity>>  invoke(){
  return homeRepository.getAllProducts();
 }
}