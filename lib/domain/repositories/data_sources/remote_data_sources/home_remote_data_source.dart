import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../entities/CategoryOrBrandResponseEntity.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllCategories();
  Future<Either<Errors,CategoryOrBrandResponseEntity>>getAllBrand();

}