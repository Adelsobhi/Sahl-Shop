import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/AddCartResponseEntity.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:sahl_shop/domain/entities/ProductResponseEntity.dart';
import 'package:sahl_shop/domain/entities/SubCategoryResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:sahl_shop/domain/repositories/home/home_repository.dart';
@Injectable(as: HomeRepository)
class HomeRepositoryImp extends HomeRepository{
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp({required this.homeRemoteDataSource});
  @override
  Future<Either<Errors, CategoryOrBrandResponseEntity>> getAllCategories()async {
    var either = await homeRemoteDataSource.getAllCategories();
    return either.fold((error)=>Left(error),
            (response)=>Right(response)
    );
}

  @override
  Future<Either<Errors, CategoryOrBrandResponseEntity>> getAllBrand()async {
    var either = await homeRemoteDataSource.getAllBrand();
    return either.fold((error)=>Left(error),
            (response)=>Right(response)
    );
  }

  @override
  Future<Either<Errors, ProductResponseEntity>> getAllProducts()async {
  var either= await homeRemoteDataSource.getAllProducts();
  return either.fold((error)=>Left(error),
          (response)=>Right(response));
  }

  @override
  Future<Either<Errors, AddCartResponseEntity>> addToCart(String productId)async {
    var either= await homeRemoteDataSource.addToCart(productId);
    return either.fold((error)=>Left(error),
            (response)=>Right(response));
  }

  @override
  Future<Either<Errors, SubCategoryResponseEntity>> getSubCategory(String categoryId)async {
    var either= await homeRemoteDataSource.getSubCategory(categoryId);
    return either.fold((error)=>Left(error),
            (response)=>Right(response));
  }
}