import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/home/home_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/CategoryOrBrandResponseEntity.dart';
@injectable
class GetAllCategoryUseCase {
  HomeRepository homeRepository;
  GetAllCategoryUseCase({required this.homeRepository});

  Future<Either<Errors, CategoryOrBrandResponseEntity>>  invoke(){
  return homeRepository.getAllCategories();
 }
}