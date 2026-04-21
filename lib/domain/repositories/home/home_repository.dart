import 'package:dartz/dartz.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';

import '../../../core/errors/errors.dart';

abstract class HomeRepository {

  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllCategories();
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllBrand();
}