import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../entities/AddCartResponseEntity.dart';
import '../../../entities/CategoryOrBrandResponseEntity.dart';
import '../../../entities/ProductResponseEntity.dart';
import '../../../entities/SubCategoryResponseEntity.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllCategories();
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllBrand();
  Future<Either<Errors,ProductResponseEntity>>getAllProducts();
  Future<Either<Errors,AddCartResponseEntity>>addToCart(String productId);
  Future<Either<Errors,SubCategoryResponseEntity>>getSubCategory(String categoryId);



}