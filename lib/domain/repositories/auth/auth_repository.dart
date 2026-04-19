import 'package:dartz/dartz.dart';
import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/RegisterResponseEntity.dart';

import '../../entities/LoginResponseEntity.dart';
abstract class AuthRepository {
  Future<Either<Errors,RegisterResponseEntity>>register(String name , String email,String password,String rePassword,String phone);
  Future<Either<Errors,LoginResponseEntity>>login( String email,String password);
}