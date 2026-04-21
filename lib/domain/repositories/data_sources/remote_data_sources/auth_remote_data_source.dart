import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../../../entities/LoginResponseEntity.dart';
import '../../../entities/RegisterResponseEntity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Errors,RegisterResponseEntity>>register(String name , String email,String password,String rePassword,String phone);
  Future<Either<Errors,LoginResponseEntity>>login( String email,String password);
 
}