import 'package:dartz/dartz.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:sahl_shop/domain/entities/SubCategoryResponseEntity.dart';

import '../../../core/errors/errors.dart';
import '../../entities/AddCartResponseEntity.dart';
import '../../entities/ProductResponseEntity.dart';

abstract class HomeRepository {

  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllCategories();
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllBrand();
  Future<Either<Errors,ProductResponseEntity>>getAllProducts();
  Future<Either<Errors,AddCartResponseEntity>>addToCart(String productId);
  Future<Either<Errors,SubCategoryResponseEntity>>getSubCategory(String productId);


}