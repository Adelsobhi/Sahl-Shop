import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/auth/auth_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/LoginResponseEntity.dart';
import '../entities/RegisterResponseEntity.dart';
@injectable
class LoginUseCase {
  AuthRepository  authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Errors, LoginResponseEntity>>invoke(String email,String password){
     return authRepository.login(email, password);
  }


}