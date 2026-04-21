import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
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
}