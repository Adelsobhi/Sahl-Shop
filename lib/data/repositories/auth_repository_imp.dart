import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/LoginResponseEntity.dart';
import 'package:sahl_shop/domain/entities/RegisterResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/auth/auth_repository.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});
  @override
  Future<Either<Errors, RegisterResponseEntity>> register(String name, String email, String password,
      String rePassword, String phone) async{
    var either= await authRemoteDataSource.register(name, email, password, rePassword, phone);
    return either.fold((error)=>Left(error), (response)=>Right(response));
  }

  @override
  Future<Either<Errors, LoginResponseEntity>> login(String email, String password) async{
    var either= await authRemoteDataSource.login(email, password);
    return either.fold((error)=>Left(error), (response)=>Right(response));
  }
}